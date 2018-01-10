REPORT ztest_compare_cds.

DATA : lv_timetaken TYPE wrbtr.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"" CDS
GET RUN TIME FIELD lv_timetaken.
SELECT * FROM zcompare INTO TABLE @DATA(lt_output1).
IF sy-subrc IS INITIAL.
  GET RUN TIME FIELD lv_timetaken.
  WRITE : / | Time taken with CDS : { lv_timetaken / 1000 } Milli Seconds. Number of rec { sy-dbcnt }| .
ENDIF.
