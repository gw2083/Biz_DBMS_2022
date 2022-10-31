-- root 권한 화면
-- wolrd SCHEMA 를 대상으로 DB를 핸들링 (CURD) 하기 위하여
-- world SCHEMA open
USE world;


-- city table 에서 인구가 5만 이상인 국가들을 표현
-- 여기에는 countryCode 가 있는데 이 코드가 무엇을 의미하는지 알기 어렵다
select name, population, countrycode
from city
where Population <= 50000;

-- countrycode 가 무엇을 의미하는지 살펴봤더니
-- 그에 대한 정보가 country table 에 있다
-- 인구가 5만 이상인 도시가 포함된 국가가 어디인가를 보면서 
-- 국가에 대한 정보도 함께 보고 싶다
select *
from country
where code = 'ANT';

/*
city table 과 country table 을 참조하여
인구가 1만 이상 5만 이하인도시의 국가정보를 같이 확인하고싶다 
인구정보는 city table 에 저장
국가정보는 country table 에 저장 
이러한 상황이 되면 2개의 테이블을 select 하여 
데이터를 확인하고 확인된 데이터를 묶어주는 절차 필요 
*/

-- 1. city table 에서 인구가 1만 이상 5만 이하 데이터 select
SELECT *
FROM city
WHERE population BETWEEN 10000 AND 50000;

-- 2. select 한 결과를 봤더니 국가에 대한 정보가 countrycode만 보여진다
-- countrycode 를 가지고 다시 country table 에서 국가정보를 select 해야한다 


-- city table 의 countryCode 데이터와 country table 의 code 데이터가
-- 일치되는 것을 찾아서 두 테이블 저보를 연결하여 보여라
-- 완전 JOIN(EQ JOIN)
-- 완전 JOIN 주의사항
-- city table countryCode 데이터가 "반드시" Country table 의 code 데이터에 존재해야 한다 
-- 만약 city 데이터에는 도시에 대한 정보가 있는데
-- 그 city 의 countryCode 에 해당하는 데이터가 country table 에 없으면
-- city 데이터의 리스트가 누락된다 
-- 완전 JOIN 은 매우 쉬운 JOIN 이지만 데이터가 누락될 수 있다 
-- 두 테이블의 교집합 연산이라고도 한다 
SELECT *
FROM city, country
WHERE city.Population BETWEEN 10000 AND 50000 AND city.countryCode = country.code;

/*
INNER JOIN
두 테이블의 교집합을 찾아 select 하기 
EQ JOIN 이라고 하고 두 테이블 간에 데이터가 완전 일치할 경우 사용 

EQ JOIN : 완전 JOIN, INNER JOIN
EQ JOIN 의 결과가 보증되려면 table 간에 "참조무결성"이 보장되어야 한다

*/
SELECT *
FROM city
	JOIN country
		ON city.countryCode = country.code
WHERE city.Population BETWEEN 10000 AND 50000 ;

/*
두 table 간에 "참조무결성" 조건이 없거나 "참조무결성" 성립이 아직 이루어 지지 않았을 경우
예를 들어 성적테이블과 학생테이블을 조일하려고 하는데 성적테이블에는 특정학번의 성적이 추가되어있으나
학생 테이블에는 특정학번의 학생 정보가 아직 추가되지않았을 경우 EQ JOIN을 수행하면 성적데이터가 보이지 않게된다
성적, 학생 두 테이블을 조인했을 때 성적테이블의 모든 데이터는 일단 보여주고 학생정보가 있으면 학생정보도 같이 보여주고
없으면 다른 표식으로 보여주면 좋겠다
= OUTER JOIN
*/

-- 1. city talbe 을 WHERE 조건에 맞도록 SELECT 하고
-- 2. select 된 list 에서 countrycode 데이터를 가지고
-- 3. country table 에서 select 를 수행한다
-- 4. country table 에서 데이터가 select 되면 해당 데이터를 보여주고alter
-- 5. 없으면 <null> 이라고 보여준다
-- 이 JOIN 은 city table 의 데이터 검증을 목적으로 한다.
SELECT *
FROM city
	LEFT JOIN country
		ON city.countryCode=country.Code
WHERE city.population BETWEEN 10000 AND 50000;