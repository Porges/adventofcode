(require '[clojure.string :as str] '[clojure.set :as set])

(defn parse-tickets [text]
  (->> (str/split text #"\n")
       (drop 1)
       (map #(map read-string (str/split % #",")))))

(defn parse-validation-ranges [input]
  (->> input
       (re-seq #"(\d+)-(\d+)")
       (map (fn [[_ l u]] (range (read-string l) (inc (read-string u)))))
       (flatten)
       (set)))

(defn parse-validation-name [line] (->> line (re-seq #"[^:]+") (first)))

(defn parse-validation [line]
  {(parse-validation-name line) (parse-validation-ranges line)})

(defn parse-validations [input]
  (->> (str/split input #"\n")
       (map parse-validation)
       (reduce merge)))

(defn part1 [definitions _ other-tickets]
  (let [valid-values (parse-validation-ranges definitions)
        value-valid? (partial contains? valid-values)]
    (->> other-tickets
         (flatten)
         (filter (complement value-valid?))
         (reduce +))))

(defn deduce-potential-columns [tickets validations] ; given tickets and map of validation name→valid values, produces a map of column number→potential column names
  (defn applicable-validations [validations value] ; produces validations where the value is valid
    (defn value-valid? [[_ valid-values]] (contains? valid-values value))
    (into {} (filter value-valid? validations)))
  (let [all-validations (repeat (count (first tickets)) validations) ; all validations are valid for all columns, initially
        validations-per-column (reduce (partial map applicable-validations) all-validations tickets)]
    (into {} (map-indexed vector (map keys validations-per-column))))) ; create a map of column-number → validation names

(defn deduce-columns [potential-column-names] ; given a map of column number→potential column names, produces a map of column number→single column name
  (loop [known {}
         to-do potential-column-names]
    (if (empty? to-do) (set/map-invert known)
      (let [{now-known true still-to-do false} (group-by (fn [[k v]] (= 1 (count v))) to-do) ; partition cols which have only one potential validation name
            new-known (into known (for [[k [v]] now-known] [v k])) ; add into known set
            except-known (partial remove (partial contains? new-known)) ; removes known columns from potential sets
            new-to-do (into {} (for [[k v] still-to-do] [k (except-known v)]))]
        (recur new-known new-to-do))))) ; assumes it won't get stuck!

(defn part2 [definitions my-ticket other-tickets]
  (let [valid-values (parse-validation-ranges definitions)
        validations (parse-validations definitions)
        value-valid? (partial contains? valid-values)
        ticket-valid? (partial every? value-valid?)
        valid-tickets (filter ticket-valid? other-tickets)
        column-names (deduce-columns (deduce-potential-columns valid-tickets validations))
        departure-columns (keys (filter #(str/starts-with? (second %) "departure") column-names))
        my-departure-values (map (partial nth my-ticket) departure-columns)]
    (reduce * my-departure-values)))

(let [input (slurp *in*)
      [definitions my-raw others-raw] (str/split input #"\n\n")
      my-ticket (first (parse-tickets my-raw))
      other-tickets (parse-tickets others-raw)]
  (println (part1 definitions my-ticket other-tickets))
  (println (part2 definitions my-ticket other-tickets)))
