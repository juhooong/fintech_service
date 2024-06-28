create schema testdb;
create database testdb2;
create database testdb3;
create database if not exists testdb2;

DROP database testdb;
DROP schema testdb2;
drop database if exists testdb3;

create database if not exists mywork;

use mywork;
show tables;
select * from student_info;

# 식별자 명명 규칙
# 식별자 : 데이터베이스 이름, 테이블 이름, 컬럼명
# 1. 최대길이 64글자까지 가능
# 2. 사용 가능 문자 0-9, 영문자, 한글, $, _를 사용할 수 있다.
# 3. 예약어(create, database, avg, show)는 사용할 수 없다.
# 4. 대소문자 구분(Windows는 관계없음), linux, unix 는 대소문자 구분

# 컬럼 생성시 주의사항
# 1. 한 테이블에 최대 4096개까지 컬럼을 만들 수 있다.
# 2. 한 테이블에서 같은 컬럼명을 사용할 수 없다.
# 3. 데이터 베이스 내에서 같은 테이블명도 사용할 수 없다.

# SQL을 사용해서 테이블 만들기 create table
use mywork;
create table highschool_students
(
 student_no   varchar(20),
 student_name varchar(100),
 grade        tinyint,
 class        varchar(50),
 gender		  varchar(20),
 age 	      smallint,
 enter_date   date
 );
 
 # 생성한 테이블의 구조를 출력 describe, desc
 describe highschool_students;
 desc highschool_students;

drop table highschool_students;

# 제약조건을 넣어 만들기 null, not null
create table highschool_students2
(
 student_no varchar(20) not null,
 student_name varchar(100) not null,
 grade tinyint null,
 class varchar(50) null,
 gender varchar(20) null,
 age smallint null,
 enter_date date
 );
 
 desc highschool_students2;
 drop table highschool_students2;
 
 # 기본키를 포함해서 만들기 (기본키 : primary key)
 create table highschool_students
 ( 
  student_no varchar(20) not null primary key,
  student_name varchar(100) not null,
  grade tinyint null,
  class varchar(50) null,
  gender varchar(20) null,
  age smallint null,
  enter_date date
 );
 desc highschool_students;
 
 drop table highschool_students;
 
 # primary key를 제일 마지막에 쓰는 방법
 create table highschool_students
 ( 
  student_no varchar(20) not null,
  student_name varchar(100) not null,
  grade tinyint null,
  class varchar(50) null,
  gender varchar(20) null,
  age smallint null,
  enter_date date,
  primary key(student_no)
 );
desc highschool_students;
drop table highschool_students;

# constraint primary key 로 설정하기
create table highschool_students
 ( 
  student_no varchar(20) not null,
  student_name varchar(100) not null,
  grade tinyint null,
  class varchar(50) null,
  gender varchar(20) null,
  age smallint null,
  enter_date date,
  constraint primary key(student_no)
 );
 desc highschool_students;

# 기본키 삭제하기 alter
# alter는 만들어진 데이터베이스나 테이블을 수정할 때 사용하는 명령어
alter table highschool_students drop primary key;
desc highschool_students;

# 기본 키 추가하기 alter add
alter table highschool_students add primary key(student_no);
desc highschool_students;

# 기본 키 생성시 주의사항
# 1. 한 테이블에서 기본키는 1개만 생성할 수 있다.
# 2. 1개 이상의 컬럼으로 기본키를 생성할 수 있다.
# 3. 기본 키 컬럼에는 not null을 적용한다.














