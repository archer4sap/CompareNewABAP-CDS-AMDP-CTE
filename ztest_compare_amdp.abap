REPORT ztest_compare_amdp.

DATA : lv_timetaken TYPE wrbtr.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" AMDP
    TYPES : BEGIN OF ty_order,
              vbeln    TYPE vbak-vbeln,
              erdat    TYPE vbak-erdat,
              erzet    TYPE vbak-erzet,
              ernam    TYPE vbak-ernam,
              angdt    TYPE vbak-angdt,
              bnddt    TYPE vbak-bnddt,
              audat    TYPE vbak-audat,
              vbtyp    TYPE vbak-vbtyp,
              trvog    TYPE vbak-trvog,
              auart    TYPE vbak-auart,
              augru    TYPE vbak-augru,
              gwldt    TYPE vbak-gwldt,
              matnr    TYPE vbap-matnr,
              delivery TYPE lips-vbeln,
              price    TYPE vbap-netpr,
              invoice  TYPE vbfa-vbeln,
            END OF ty_order.

DATA : lo_ref TYPE REF TO zcompare_class,
       et_order TYPE TABLE OF ty_order,
       lv_lines TYPE sy-dbcnt.


CREATE OBJECT lo_ref.

CLEAR : sy-dbcnt, lv_timetaken.

GET RUN TIME FIELD lv_timetaken.
lo_ref->my_method( IMPORTING et_order    = et_order ).
IF et_order IS NOT INITIAL.
  GET RUN TIME FIELD lv_timetaken.
  describe TABLE et_order LINES lv_lines.
  WRITE : / | Time taken with AMDP : { lv_timetaken / 1000 } Milli Seconds. Number of rec { lv_lines }| .
ENDIF.
