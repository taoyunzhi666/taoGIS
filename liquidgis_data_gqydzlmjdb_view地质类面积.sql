create or replace view liquidgis_data_gqydzlmjdb_view as
select zuizui."CODE",zuizui."XZQHMC",zuizui."YSMC",zuizui."GPGS",zuizui."DZLGS",zuizui."GPMJ",zuizui."DZLMJ",zuizui."CZ",zuizui."CZL",zuizui."CDMJ",zuizui."JGPY",zuizui."JDZLY",(zuizui.gpgs-zuizui.dzlgs) gscz
,zuizui.ysdm
 from (
select "CODE","XZQHMC","YSMC","GPGS","DZLGS","GPMJ","DZLMJ","CZ","CZL","CDMJ","JGPY","JDZLY" ,"YSDM"from (
select to_char('441302000000') code,to_char('»ÝÖÝÊÐ') xzqhmc, t.ysmc , sum(t.gpgs) gpgs ,sum(t.dzlgs) dzlgs ,sum(t.gpmj) gpmj, sum(t.dzlmj) dzlmj,sum(t.gpmj)-sum(t.dzlmj) cz
,to_char(round( ((sum(t.gpmj)-sum(t.dzlmj))/sum(t.gpmj))*100,2) ) czl,sum(t.cdmj) cdmj, sum(t.gpmj)-sum(t.cdmj) jgpy ,
sum(t.dzlmj)-sum(t.cdmj)  jdzly,t.ysdm from GQYDZLMJDB_VIEW1 t group by t.ysmc,t.ysdm
union all (select to_char(zuizhong.code),to_char(zuizhong.xzqhmc),zuizhong.ysmc,zuizhong.gpgs,zuizhong.dzlgs,
zuizhong.gpmj,zuizhong.dzlmj,zuizhong.cz,case when zuizhong.gpmj=0 then '-' else to_char(round(zuizhong.czl*100,2)) end  czl,zuizhong.cdmj,zuizhong.jgpy
,zuizhong.jdzlmj ,zuizhong.ysdm  from   (
select jieguo.dm3 CODE,jieguo.mc3 xzqhmc,jieguo.ysmc, nvl(jieguo.gpgs,0) gpgs,
jieguo.dzlgs,nvl((jieguo.gpgs-jieguo.dzlgs),0) gscz
,nvl(round(jieguo.gpmj/1000000,2),0) gpmj,nvl(round(jieguo.dzlmj/1000000,2),0) dzlmj, round((nvl(round(jieguo.gpmj/1000000,2),0)-nvl(round(jieguo.dzlmj/1000000,2),0)) ,2) cz ,
case when nvl(round(jieguo.gpmj/1000000,2),0)=0 then '-' else  to_char( round ( (nvl(round(jieguo.gpmj/1000000,2),0)-nvl(round(jieguo.dzlmj/1000000,2),0))/(nvl(round(jieguo.gpmj/1000000,2),0)) ,4) )
end   czl,nvl(round(jieguo.cdmj/1000000,2),0) cdmj,
nvl(round((jieguo.gpmj-jieguo.cdmj)/1000000,2),0) jgpy,
nvl(round((jieguo.dzlmj-jieguo.cdmj)/100000,2),0) jdzlmj, '1020' ysdm from (
select *
  from (select  sum(a.shape.area) gpmj, a.zqmc, count(distinct(a.name)) gpgs
          from SDE.HYDA_HZ a
         where a.cc = '1020'
         group by a.zqmc) aa
 right join (select sum(b.shape.area) cdmj, b.zqmc mc2 ,b.zqdm
               from SDE.hyda_hp_intersect b
              group by b.zqmc, b.zqdm) bb on aa.zqmc = bb.mc2
 right join (select 'ºþ²´' ysmc,
                    sum(c.shape.area) dzlmj,
                    c.zqmc mc3,c.zqdm dm3,
                    count(distinct(c.name)) dzlgs
               from SDE.HP_HZ c
              group by c.zqmc,c.zqdm) cc on bb.mc2 = cc. mc3) jieguo

              union (select jieguo.dm3 xzqdm,jieguo.mc3 xzqhmc,jieguo.ysmc, nvl(jieguo.gpgs,0) gpgs,
jieguo.dzlgs,nvl((jieguo.gpgs-jieguo.dzlgs),0) gscz
,nvl(round(jieguo.gpmj/1000000,2),0) gpmj,nvl(round(jieguo.dzlmj/1000000,2),0) dzlmj,nvl(round((jieguo.gpmj-jieguo.dzlmj)/1000000,2),0) cz ,
to_char(round((jieguo.gpmj-jieguo.dzlmj)/jieguo.gpmj,4)) czl,nvl(round(jieguo.cdmj/1000000,2),0) cdmj,
nvl(round((jieguo.gpmj-jieguo.cdmj)/1000000,2),0) jgpy,
nvl(round((jieguo.dzlmj-jieguo.cdmj)/100000,2),0) jdzlmj,'1031' ysdm¡¡from (
select *
  from (select  sum(a.shape.area) gpmj, a.zqmc, count(distinct(a.name)) gpgs
          from SDE.HYDA_HZ a
         where a.cc in( '1031','1032')
         group by a.zqmc) aa
 right join (select sum(b.shape.area) cdmj, b.zqmc mc2 ,b.zqdm
               from SDE.kt_sk_intersect_hz b
              group by b.zqmc, b.zqdm) bb on aa.zqmc = bb.mc2
 right join (select 'Ë®¿â' ysmc,
                    sum(c.shape.area) dzlmj,
                    c.zqmc mc3,c.zqdm dm3,
                    count(distinct(c.name)) dzlgs
               from SDE.SK_HZ c
              group by c.zqmc,c.zqdm) cc on bb.mc2 = cc. mc3) jieguo
              )) zuizhong

)) order by ysmc) zuizui

