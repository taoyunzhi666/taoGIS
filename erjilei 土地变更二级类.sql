create or replace view erjilei as
select      jieguo.zqdm2  code, jieguo.zqmc2 xzqhmc,jieguo.cc2 ysdm,
jieguo.linklca ysmc,jieguo.gpmj,jieguo.bgmj,
(jieguo.gpmj-jieguo.bgmj) cz, ((jieguo.gpmj-jieguo.bgmj)/jieguo.gpmj) czl,jieguo.cdmj,
 jieguo.gpmj-jieguo.cdmj jgpy,jieguo.bgmj-jieguo.cdmj jtdbgy    from (
select * from (
(select sum(a.sum_shape_) gpmj,a.ccfinal,a.erjilei,a.zqmc zqmc1,a.zqdm from LCA_Statistics5 a where a.erjilei is
not null  group by a.ccfinal,a.erjilei,a.zqmc ,a.zqdm  ) aa right join (

 select sum(c.sum_shape_) bgmj,c.zqmc zqmc2,c.linklca ,c.zqdm zqdm2,c.cc2  from DLTB_dilei c where c.linklca is not null group by c.zqmc,c.linklca ,
 c.zqdm ,c.cc2 order by c.zqmc) cc on aa.zqmc1=cc.zqmc2 and aa.erjilei=cc.linklca

 left join (
 select sum(bb.sum_shape_) cdmj,bb.xiangjiao,bb.zqmc from (
 select case when b.cc='0110' and b.DLMC='水田' then '水田'
  when b.CC='0120' and (b.DLMC='旱地' or b.DLMC='水浇地') then '旱地'
   when b.CC like '021%' and b.DLMC='果园'  then '果园'
    when b.CC ='0220' and b.DLMC='茶园' then '茶园'
     when b.CC in('0230','0240','0250','0260','0291','0292','0293') and b.DLMC ='其他园地' then '其他园地'
      when b.CC like '031%' and b.DLMC ='有林地' then '有林地'
       when b.CC like '032%' and b.DLMC='灌木林地' then '灌木林地' when b.CC in
       ('0330','0340','0350','0360','0370','0380') and b.DLMC ='其他林地' then '其他林地'
        when b.CC in('0411','0412','0413') and b.DLMC ='天然牧草地' then '天然牧草地'
          when b.CC ='0421' and b.DLMC ='人工牧草地' then '人工牧草地'
            when b.CC in('0422','0423','0424','0429') and b.DLMC ='其他草地' then '其它草地'
              when b.CC in('1011','1012')and (b.DLMC ='河流水面'Or b.DLMC = '沟渠') then '河渠'
               when b.CC in('1020') and b.DLMC ='湖泊水面' then '湖泊'
                when b.CC in('1031','1032') and (b.DLMC ='水库水面' Or b.DLMC ='坑塘水面') then '库塘'
               end xiangjiao ,b.*

   from LCA_Intersect3_dltb_all_Stat b   ) bb where bb.xiangjiao is not null group by bb.xiangjiao,bb.zqmc
   ) bbb on cc.zqmc2=bbb.zqmc and cc.linklca=bbb.xiangjiao
 )  ) jieguo order by jieguo.zqmc1


 /*select * from DLTB_dilei*/

