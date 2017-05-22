create or replace view liquidgis_data_gqytdbgdb_view as
select zuizhong.code,zuizhong.xzqhmc,zuizhong.ysdm,zuizhong.ysmc,nvl(round(zuizhong.gpmj,2),0) gpmj
,nvl(round(zuizhong.bgmj,2),0) bgmj,round((nvl(round(zuizhong.gpmj,2),0)-nvl(round(zuizhong.bgmj,2),0)),2) cz,  case when  nvl(round(zuizhong.gpmj,2),0) =0 then 0 else
round(((nvl(round(zuizhong.gpmj,2),0)-nvl(round(zuizhong.bgmj,2),0))/nvl(round(zuizhong.gpmj,2),0)),4)*100 end  czl ,
nvl(round(zuizhong.cdmj,2),0) cdmj,nvl(round(zuizhong.gpmj,2),0)-nvl(round(zuizhong.cdmj,2),0) jgpy,
round(nvl(round(zuizhong.bgmj,2),0)-nvl(round(zuizhong.cdmj,2),0),2) jtdbgy from (
(select to_char(a.code) code,to_char(a.xzqhmc) xzqhmc,to_char(a.ysdm) ysdm,to_char(a.ysmc) ysmc,a.gpmj,a.bgmj,a.cz,a.czl,a.cdmj,a.jgpy,a.jtdbgy  from GQYTDBGDB_VIEWtest a )
union all
(select  to_char(b.code),to_char(b.xzqhmc),to_char(b.ysdm),b.ysmc,b.gpmj,b.bgmj,b.cz,b.czl,b.cdmj,b.jgpy,b.jtdbgy  from erjilei b ))
zuizhong

