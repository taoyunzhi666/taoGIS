CREATE OR REPLACE VIEW GQYDZLCDDB_VIEW1 AS
select case when zuizhong.ysmc='河渠' then '1010'  when zuizhong.ysmc='铁路' then '0610' when zuizhong.ysmc='公路' then '0620' end ysdm,zuizhong.ysmc,zuizhong.zqmc xzqhmc,zuizhong.gpcd,zuizhong.dzlcd,zuizhong.code,zuizhong.cz from (
select '铁路' ysmc ,jieguo.zqmc,round(jieguo.gpcd/1000,2) gpcd,
round(nvl(jieguo.dzlcd,0)/1000,2) dzlcd,jieguo.zqdm code,round(round(jieguo.gpcd/1000,2)-round(nvl(jieguo.dzlcd,0)/1000,2),2) cz from  (
 select * from (
 (select sum(a.shape.len) gpcd,a.zqmc,a.zqdm from sde.lrrl_hz a group by a.zqmc,a.zqdm) aa left join
 (select sum(b.shape.len) dzlcd ,b.zqdm dm2,b.zqmc mc2  from sde.tl_hz b group by b.zqdm,b.zqmc) bb
  on aa.zqmc=bb.mc2)) jieguo
 UNION(
 SELECT  '河渠' YSMC ,JIEGUO.MCA XZQHMC,round(JIEGUO.GPCD/1000,2),round(JIEGUO.ZTCD/1000,2),JIEGUO.DM CODE,round((JIEGUO.GPCD-JIEGUO.ZTCD)/1000,2)  CZ FROM (
 select  *  from
  (
 select sum(a.shape.len) gpcd  ,a.zqmc mca,a.zqdm dm from SDE.HYDL_HZ a where a. CC in('1011','1012') group by a.zqmc,a.zqdm)    aa  left join (
  select sum(b.shape.len) ztcd ,b.zqmc  mcb from SDE.HL_HZ b group by b.zqmc)      bb on aa.mca=bb.mcb) JIEGUO)
   union all (select '公路' ysmc,bb.zqmc2,round(aa.gpcd/1000,2),round(bb.dzlcd/1000,2),bb.zqdm2,round((aa.gpcd-bb.dzlcd)/1000,2) cz from (
(select sum(a.shape.len) gpcd,a.zqmc,a.zqdm from SDE.LRDL_HZ a  where a.RN Like'G%'or a.RN Like'S%' group by a.zqmc,a.zqdm)   aa
left join (select sum(jj.shape.len) dzlcd,jj.zqmc zqmc2,jj.zqdm zqdm2 from (
select * from SDE.SD_HZ  union all(
select * from SDE.GD_HZ))  jj group by jj.zqmc,jj.zqdm)  bb on aa.zqdm=bb.zqdm2 ) )) zuizhong

