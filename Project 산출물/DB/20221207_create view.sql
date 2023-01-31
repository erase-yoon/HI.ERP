create view ma_emp_tmp_jik    as
select tmp.no_emp, tmp.nm_emp, tmp.enter_date, tmp.birth_date, tmp.retire_date, tmp.cd_emp, tmp.cd_dept, tmp.user_id, tmp.user_pwd, tmp.email, tmp.nm_addr, tmp.phone, tmp.no_res
,tmp.cd_jik , jik.nm_jik
from ma_emp_tmp tmp inner join ma_jikup jik
on tmp.cd_jik = jik.cd_jik;


select * from ma_emp_tmp_jik

create view ma_emp_total as
select tmpj.no_emp, tmpj.nm_emp, tmpj.enter_date, tmpj.birth_date, tmpj.retire_date, tmpj.cd_emp, tmpj.cd_jik, tmpj.cd_dept, tmpj.user_id, tmpj.user_pwd, tmpj.email, tmpj.nm_addr, tmpj.phone, tmpj.no_res
, tmpj.nm_jik, dep.nm_dept
from ma_emp_tmp_jik tmpj join ma_dept dep
on tmpj.cd_dept = dep.cd_dept;