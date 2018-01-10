REPORT ztest_compare_cte.

DATA : lv_timetaken TYPE wrbtr.
"""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

*" CTE
CLEAR : sy-dbcnt, lv_timetaken.
GET RUN TIME FIELD lv_timetaken.
WITH
+part_vbak AS (
    SELECT vbeln,
       erdat,
       erzet,
       ernam,
       angdt,
       bnddt,
       audat,
       vbtyp,
       trvog,
       auart,
       augru,
       gwldt
       FROM vbak ),

  +part_vbap AS ( SELECT DISTINCT
       a~vbeln,
       b~posnr,
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
       SUM( b~netpr ) AS price
         FROM +part_vbak AS a
         INNER JOIN vbap AS b
            ON a~vbeln = b~vbeln
            GROUP BY
               a~vbeln,
               b~posnr,
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
               b~matnr
  ) ,

  +part_lips AS (  SELECT DISTINCT
       x~vbeln,
       x~posnr,
       x~erdat,
       x~erzet,
       x~ernam,
       x~angdt,
       x~bnddt,
       x~audat,
       x~vbtyp,
       x~trvog,
       x~auart,
       x~augru,
       x~gwldt,
       x~matnr,
       x~price,
       c~vbeln AS delivery,
       c~posnr AS devivery_posnr
         FROM +part_vbap AS x
         INNER JOIN lips AS c
            ON c~vgbel = x~vbeln
                AND c~vgpos = x~posnr
  ) ,
  +part_vbrp AS ( SELECT DISTINCT
       y~vbeln,
       y~erdat,
       y~erzet,
       y~ernam,
       y~angdt,
       y~bnddt,
       y~audat,
       y~vbtyp,
       y~trvog,
       y~auart,
       y~augru,
       y~gwldt,
       y~matnr,
       y~price,
       y~delivery
         FROM +part_lips AS y
         INNER JOIN vbrp AS d
            ON y~delivery = d~vgbel
                AND y~devivery_posnr = d~vgpos
  )

  SELECT DISTINCT * FROM +part_vbrp INTO TABLE @DATA(lt_result2).
IF sy-subrc IS INITIAL.
  GET RUN TIME FIELD lv_timetaken.
  WRITE : / | Time taken with CTE : { lv_timetaken / 1000 } Milli Seconds. Number of rec { sy-dbcnt }| .
ENDIF.
