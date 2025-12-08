(import srfi-1 srfi-13 (chicken io) (chicken string))

(define (op c) (cond [(equal? c "+") +] [(equal? c "*") *]))

(define (clump xs) ; group elements separated by #f
  (let-values (((g tail) (span identity xs)))
    (cons g (if (null? tail) '() (clump (cdr tail))))))

(define (skew xs) (apply map (compose list->string list) (map string->list xs)))

(let*
  ((lines (read-lines))

   (calc (lambda (o . ls) (apply (op o) (map string->number ls))))
   (part1 (apply + (apply map calc (reverse (map string-split lines)))))

   (parsed-nums (clump (map (o string->number string-trim-both) (skew (butlast lines)))))
   (ops (map op (string-split (last lines))))
   (part2 (apply + (map apply ops parsed-nums))))

  (display part1) (newline)
  (display part2) (newline))
