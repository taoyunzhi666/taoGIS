create or replace view gqytdbgdb_viewtest as
select "CODE","XZQHMC","YSDM","YSMC","GPMJ","BGMJ","CZ","CZL","CDMJ","JGPY","JTDBGY" from (select to_char('441320000000') code,to_char(N'»ÝÖÝÊÐ') xzqhmc,  a.ysdm,a.ysmc ,sum(a.gpmj) gpmj,sum(a.bgmj) bgmj,sum(a.gpmj) - sum(a.bgmj) cz ,
(sum(a.gpmj) - sum(a.bgmj))/sum(a.gpmj) czl,sum(a.cdmj) cdmj, sum(a.gpmj)-sum (a.cdmj) jgpy,
sum(a.bgmj)-sum(a.cdmj) jtdbgy
from tdbg a  group by a.ysmc,a.ysdm
union all(select to_char(a.code),to_char(a.xzqhmc),a.ysdm,a.ysmc,a.gpmj,a.bgmj
,a.cz,a.czl,a.cdmj,a.jgpy,a.jtdbgy from  tdbg a)) order by ysmc

