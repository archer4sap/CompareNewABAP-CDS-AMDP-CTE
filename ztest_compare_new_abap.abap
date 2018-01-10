REPORT ztest_compare_new_abap.

DATA : lv_timetaken TYPE wrbtr.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" New Open SQl
GET RUN TIME FIELD lv_timetaken.

SELECT DISTINCT a~vbeln,
       a~erdat,
       a~erzet,
       a~ernam,
       a~angdt,
       a~bnddt,
       a~audat,
       a~vbtyp,
       a~trvog,
       a~auart,
       a~augru,
       a~gwldt,
       b~matnr,
       c~vbeln AS delivery,
       SUM( b~netpr ) AS price,
       d~vbeln AS invoice
         FROM vbak AS a
         INNER JOIN vbap AS b
            ON a~vbeln = b~vbeln
         INNER JOIN lips AS c
            ON c~vgbel = b~vbeln
                AND c~vgpos = b~posnr
         INNER JOIN vbrp AS d
            ON c~vbeln = d~vgbel
                AND c~posnr = d~vgpos
       GROUP BY a~vbeln,
                a~erdat,
                a~erzet,
                a~ernam,
                a~angdt,
                a~bnddt,
                a~audat,
                a~vbtyp,
                a~trvog,
                a~auart,
                a~augru,
                a~gwldt,
                b~matnr,
                c~vbeln,
                d~vbeln
       INTO TABLE @DATA(lt_output).
IF sy-subrc IS INITIAL.
  GET RUN TIME FIELD lv_timetaken.
  WRITE : / | Time taken with new Open SQL : { lv_timetaken / 1000 } Milli Seconds. Number of rec { sy-dbcnt }| .
ENDIF.
