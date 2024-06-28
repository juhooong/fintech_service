show databases;
use titanic;
show tables;

select * from p_info;
select * from ticket;
select Name, Age from p_info limit 3;
select * from p_info where Sex = "male";
# => 왼쪽이 오른쪽 보다 크거나 같다.;

select * from p_info where Age >= 30;
select * from p_info where Sex != "male";
select * from p_info where SibSp <= 1;
SELECT * FROM p_info WHERE Age <= 20;
select * from p_info where Age < 20 and Sex = 'male';
select * from p_info where Age < 20 and Sex = 'male' or Parch > 3;
				   #          참    and   참  =  참
select * from p_info where Age >= 20 and Age < 50 and Sex = "female";
select * from p_info where SibSp >= 1 and Parch >= 1;
select * from t_info;
select * from t_info where Pclass = 1;
select * from t_info where Pclass =2 or fare > 50;
select * from survived;
select * from survived where survived = 1;
select * from p_info;
select * from p_info where Name like 'Braund%';
select * from p_info where Name like '%Laina';
select * from p_info where Name like '%Mrs%';
select * from p_info where Name not like '%Mrs%';

# in 안에 값이 있는 경우 가져오기
select * from p_info where SibSp = 4 or SibSp = 5 or Sibsp = 6;
select * from p_info where SibSp in(4,5,6); # or
# not in
select * from p_info where SibSp not in(2,3,4,5,6); # and
# between a and b = a 이상 b 이하
# p_info Age가 40이상, 60이하인 사람을 검색하세요.
select * from p_info where Age >= 40 and Age <= 60;
select * from p_info where Age between 40 and 60;

# is null/ is not null(결측치, 값이 없음)
# Age 컬럼에서 NULL이 있는지 찾기.
select * from p_info where Age is null;

select * from p_info where Age is not null;

select * from t_info where Fare between 100 and 1000;

select * from t_info where Ticket like 'PC%' and (Embarked = 'C' or Embarked = 'S');
select * from t_info where Ticket like 'PC%' and Embarked = ('C' or 'S');
select * from t_info where Ticket like 'PC%' and Embarked in('C','S');

select * from t_info where Pclass = 1 or Pclass = 2;
select * from t_info where Pclass in (1,2);

select * from t_info where Cabin like '%59%';
select * from p_info where Age is not null and Name like '%James%' and Age >=40 and Sex = 'male';

# select * from where order by, group by
# select * from 테이블명 where 컬럼명 order by 기준컬럼 ASC(오름차순), DESC(내림차순) 
# p_info 테이블에서 age가 null이 아니면서 이름에 miss가 포함된 40세 이하의 여성을 조회하고 나이순으로 내림차순 정렬
select * from p_info where Age is not null and Name like '%miss%' and Age <= 40 
and sex = 'female' order by Age DESC;

# p_info 테이블에서 나이가 null이 아닌 행의 성별별 나이 평균을 구하시오.
select * from p_info;
select sex, AVG(age) from p_info where Age is not null group by sex;
select sex, AVG(age), MIN(age), MAX(age) from p_info where Age is not null group by Sex;
select Sibsp, AVG(age), MIN(age), MAX(age) from p_info where Age is not null group by Sibsp order by Sibsp ASC;

# having : group by 한 결과에서 원하는 조건을 맞는 결과만 다시 추릴 때, where
# t_info 테이블에서 pclass별 fare 가격 평균을 구하고 그 중 가격 평균이 50을 초과하는 결과만 조회
# pclass별 fare 가격 평균 : group by pclass, AVG(fare), AVG(fare) > 50
select * from t_info;
select pclass, AVG(fare) from t_info group by pclass 
having AVG(fare) > 50;

# inner join(교집합) 
# select * from 테이블1(왼쪽) as 별칭 inner join 테이블2(오른쪽) as 별칭2
# on 테이블1의 기준컬럼 = 테이블2의 기준컬럼;
select * from passenger;
select * from ticket; 
# passenger와 ticket의 inner join
select passengerID, Name from passenger as p inner join ticket as t on p.PassengerID = t.PassengerID;
select * from passenger as p inner join ticket as t on p.PassengerID = t.PassengerID;

# left join
select * from passenger as p left join ticket as t on p.PassengerId = t.PassengerId;

# right join
select * from passenger as p right join ticket as t on p.PassengerId = t.PassengerId;

# full outer join : mysql에서 지원 X, union이란 명령어로 left join 결과와 right join 결과를 합침.
select * from passenger as p left join ticket as t on p.PassengerId = t.PassengerId
UNION
select * from passenger as p right join ticket as t on p.PassengerId = t.PassengerId;

# 원하는 컬럼만 조회하기 : 컬럼명을 그대로 적어준다. 단, 컬럼명이 중복되면 어느 테이블인지 명시한다.
select t.PassengerId, p.Name, p.Age, t.Pclass, t.Embarked 
from passenger as p 
left join ticket as t 
on p.PassengerId = t.PassengerId;

# 3개 이상의 테이블을 조인하기
# passenger, ticket, survived inner join 합쳐서 전체 컬럼을 출력하시오.
select * from passenger as p 
inner join ticket as t
on p.PassengerId = t.PassengerId
inner join survived as s
on p.PassengerId = s.PassengerId;

#1 passenger, ticket, survived 테이블을 inner 조인하고 survived가 1인 사람들만 찾아서 Name, Age, Sex, Pclass, survived 컬럼을 출력하시오

select Name, Age, Sex, Pclass, survived from passenger as p
inner join ticket as t
on p.PassengerId = t.PassengerId
inner join survived as s 
on p.PassengerId = s.PassengerId
where survived = 1;

#2 1의 결과를 10개만 출력하시오.

select Name, Age, Sex, Pclass, survived from passenger as p
inner join ticket as t
on p.PassengerId = t.PassengerId
inner join survived as s 
on p.PassengerId = s.PassengerId
where survived = 1
limit 10;

#3 Passenger 테이블을 기준 ticket, survived테이블을 기준 ticket, survived테이블을 LEFT JOIN한 결과에서 성별이 여성이면서 Pclass가 1인 사람 중 
# 생존자(survived=1)를 찾아 이름, 성별, Pclass를 표시하시오.
select name, sex, pclass from passenger as p
left join ticket as t on p.passengerId = t.passengerId
left join survived as s on p.passengerId = s.passengerId
where sex = 'female' and pclass =1 and survived =1;

#4 passenger, ticket, survived 테이블을 left join 후 
# 나이가 10세 이상 20세 이하이면서 Pclass 2인 사람 중 생존자를 표시하시오.
select * from passenger as p 
left join ticket as t on p.passengerId = t.passengerId 
left join survived as s on p.passengerId = s.passengerId
where age between 10 and 20 and Pclass = 2 and survived = 1;

#5 passenger, ticket, survived 테이블을 left join 후 
# 성별이 여성 또는 Pclass가 1인 사람 중 생존자를 표시하시오.
select * from passenger as p left join
ticket as t on p.passengerId = t.passengerId left join
survived as s on p.passengerId = s.passengerId
where (sex = 'female' or Pclass = 1) and survived = 1;

#6 passenger, ticket, survived 테이블을 left join 후
# 생존자 중에서 이름에 Mrs가 포함된 사람을 찾아 이름, Pclass, 나이, Parch, Survived를 표시하시오.
 select Name, Pclass, Parch, Survived from passenger as p 
 left join ticket as t on p.passengerId = t.passengerId 
 left join survived as s on p.passengerId = s.passengerId
where survived = 1 and name like '%Mrs%';

#7 passenger, ticket, survived 테이블을 left join 후 Pclass가 1,2이고
# Embarked가 s,c인 사람 중에서 생존자를 찾아 이름, 성별, 나이를 표시하시오.
select Name, Sex, Age from passenger as p 
left join ticket as t on p.passengerId = t.passengerId
left join survived as s on p.passengerId = s.passengerId
where (Pclass in(1,2) and Embarked in('s','c')) and survived =1;

# and, or => and 먼저 or 나중
select * from ticket where (pclass = 1 or pclass = 3) and embarked = 'C';
select * from ticket where pclass in(1, 3) and embarked = 'C';

#8 passenger, ticket, survived 테이블을 left join 후 이름에 James가 들어간
# 사람중 생존자를 찾아 이름, 성별, 나이를 표시하고 나이를 기준으로 내림차순 정렬하시오.
select Name, Sex, Age from passenger as p
left join ticket as t on p.passengerId = t.passengerId
left join survived as s on p.passengerId = s.passengerId
where Name like '%James%' and survived = 1 order by Age desc;


#9 passenger, ticket, survived 테이블을 inner join한 데이터에서
# 성별별, 생존자의 숫자를 구하시오. 생존자 숫자 결과는 별칭을 ToTal로 하시오.
select sex, count(survived) as Total from passenger as p
inner join ticket as t on p.PassengerId = t.PassengerId
inner join survived as s on p.PassengerId = s.PassengerId
where survived = 1 group by sex;

#10 passenger, ticket, survived 테이블을 INNER JOIN한 데이터에서
# 성별별, 생존자의 숫자, 생존자 나이의 평균을 구하시오.
# 생존자 숫자 결과는 별칭을 Total로 하시오.
select sex, count(survived) as Total, avg(Age) from passenger as p 
INNER JOIN ticket as t on p.PassengerId = t.PassengerId
INNER JOIN survived as s on p.PassengerId = s.PassengerId
where survived = 1 group by sex;





















