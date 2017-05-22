create or replace view liquidgis_data_gqylytmjdb_view as
select     aaa.zqdm1  code  ,aaa.zqmc1 xzqhmc,aaa.ysdm,aaa.ysmc1 ysmc,aaa.gpmj,round(nvl(aaa.lytmj,0),2) lytmj ,
aaa.gpmj-round(nvl(aaa.lytmj,0),2) cz,round((aaa.gpmj-round(nvl(aaa.lytmj,0),2))*100/aaa.gpmj,2) czl ,round(nvl(aaa.cdmj,0),2)  cdmj,
aaa.gpmj-round(nvl(aaa.cdmj,0),2) jgpy,
round(nvl(aaa.lytmj,0),2)-round(nvl(aaa.cdmj,0),2) jlyty   from (
select * from (
(select a.ysmc ysmc1,a.zqdm zqdm1,a.zqmc zqmc1,round(a.sum_shape_,2)  gpmj ,a.ysdm  from  lca_lytt_Statistics a) aa left join
(select c.ysmc ,c.zqdm,c.zqmc,round(c.sum_shape_,2) lytmj from data_2000BL_HZ1_Statistics4 c) cc on
aa.ysmc1=cc.ysmc and aa.zqdm1=cc.zqdm
left join (select b.zqmc,b.zqdm,b.ysmc,sum(b.sum_shape_) cdmj from lca_lytt_intersect_statistic b group by  b.zqmc,b.zqdm,b.ysmc  ) bb
 on aa.ysmc1=bb.ysmc
and aa.zqdm1=bb.zqdm
)  ) aaa   order by aaa.ysmc1

