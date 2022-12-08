       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY07-PART2.

       DATA DIVISION.
       LOCAL-STORAGE SECTION.
      * calculated and entered by hand, boo:
       78 TARGET           VALUE 3313415.

       01 LS-LINE          PIC X(100).
       01 CMD              PIC X(100) OCCURS 3 TIMES.
       01 LS-STACK-COUNT   PIC 99 VALUE 0.
       01 LS-SIZE          PIC 9(10) OCCURS 0 TO 99 TIMES
                           DEPENDING ON LS-STACK-COUNT.
       01 LS-CURRENT-BEST  PIC 9(10) VALUE 999999999.
       01 LS-RESULT        PIC 9(10) VALUE 0.

       PROCEDURE DIVISION.
         PERFORM READ-LINE UNTIL LS-RESULT > 0.
         DISPLAY LS-RESULT.
         STOP RUN.

       POP-STACK.
         IF LS-SIZE(LS-STACK-COUNT) <= LS-CURRENT-BEST AND
            LS-SIZE(LS-STACK-COUNT) >= TARGET
          SET LS-CURRENT-BEST TO LS-SIZE(LS-STACK-COUNT)
         END-IF.
         ADD LS-SIZE(LS-STACK-COUNT) TO LS-SIZE(LS-STACK-COUNT - 1).
         SUBTRACT 1 FROM LS-STACK-COUNT.

       PUSH-STACK.
         ADD 1 TO LS-STACK-COUNT.
         SET LS-SIZE(LS-STACK-COUNT) TO 0.

       READ-LINE.
         ACCEPT LS-LINE ON EXCEPTION 
           PERFORM POP-STACK UNTIL LS-STACK-COUNT EQUALS 0
           SET LS-RESULT TO LS-CURRENT-BEST
           EXIT PARAGRAPH.

         UNSTRING LS-LINE DELIMITED BY SPACE INTO
           CMD(1) CMD(2) CMD(3).

         IF CMD(1) = "$"
           IF CMD(2) = "cd"
              IF CMD(3) = ".."
                 PERFORM POP-STACK
              ELSE 
                 PERFORM PUSH-STACK
              END-IF
           END-IF
         ELSE
           ADD FUNCTION NUMVAL(CMD(1)) TO LS-SIZE(LS-STACK-COUNT)
         END-IF.
