       IDENTIFICATION DIVISION.
       PROGRAM-ID. DAY07-PART1.

       DATA DIVISION.
       LOCAL-STORAGE SECTION.
       78  MAX-SIZE       VALUE 100000.
       01  LS-LINE        PIC X(100).
       01  LS-CMD         PIC X(100) OCCURS 3 TIMES.
       01  LS-STACK-COUNT PIC 99 VALUE 0.
       01  LS-SIZE        PIC 9(10) OCCURS 0 TO 99 TIMES
                          DEPENDING ON LS-STACK-COUNT.
       01  LS-GLOBAL-SUM  PIC 9(10) VALUE 0.
       01  LS-RESULT      PIC 9(10) VALUE 0.

       PROCEDURE DIVISION.
           PERFORM READ-LINE UNTIL LS-RESULT > 0.
           DISPLAY "TOTAL SIZE: " LS-SIZE(1).
           DISPLAY "ANSWER: " LS-RESULT.
           STOP RUN.

       POP-STACK.
           IF LS-SIZE(LS-STACK-COUNT) <= MAX-SIZE
              THEN ADD LS-SIZE(LS-STACK-COUNT) TO LS-GLOBAL-SUM.
           ADD LS-SIZE(LS-STACK-COUNT) TO LS-SIZE(LS-STACK-COUNT - 1).
           SUBTRACT 1 FROM LS-STACK-COUNT.

       PUSH-STACK.
           ADD 1 TO LS-STACK-COUNT.
           SET LS-SIZE(LS-STACK-COUNT) TO 0.

       READ-LINE.
           ACCEPT LS-LINE
              ON EXCEPTION 
              PERFORM POP-STACK UNTIL LS-STACK-COUNT EQUALS 0
              SET LS-RESULT TO LS-GLOBAL-SUM
              EXIT PARAGRAPH.

           UNSTRING LS-LINE DELIMITED BY SPACE
              INTO LS-CMD(1) LS-CMD(2) LS-CMD(3).

           IF LS-CMD(1) = "$"
              IF LS-CMD(2) = "cd"
                 EVALUATE LS-CMD(3)
                 WHEN ".." PERFORM POP-STACK
                 WHEN OTHER PERFORM PUSH-STACK
                 END-EVALUATE
              END-IF
           ELSE
           ADD FUNCTION NUMVAL(LS-CMD(1)) TO LS-SIZE(LS-STACK-COUNT)
           END-IF.