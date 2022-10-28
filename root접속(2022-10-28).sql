-- 여기는 주석문
-- 여기는 root 로 접속한 화면입니다
-- SELECT : DB Server 에 뭔가 요청하는 명령 키워드
SELECT 30+40;
SELECT '대한민국만세';

-- || : Oracle 에서 문자열 연결, '대한민국' || '만세'
SELECT CONCAT('대한민국','만세');

-- world SCHEMA를 open하기
-- SCHEMA = DATABASE
USE world; -- 1. DB 를 open 하고
SELECT * FROM city; -- 2. city table 에서 데이터를 SELECT(선택)하여 보여주기

-- WHERE 조건절에 조건을 부여하여 필요한 데이터만 제한적으로 SELECT 하기
SELECT * FROM city
WHERE District = 'Noord-Holland';

SELECT * FROM city
WHERE Name = 'Alkmaar';

SELECT * FROM city;

-- Selection 조회
-- 데이터 개수를 축소하여 필요한 데이터들만 보기
SELECT * FROM city
WHERE NAME = 'Herat';

-- Projection 조회
-- 데이터 항목을 축소하여 필요한 항목(column)들만 보기
SELECT Name, Population
FROM city;

-- Selection 과 Projection 동시에 적용하기
SELECT District, Population
FROM city
WHERE name = 'Herat';

-- district 칼럼에 저장된 데이터들을 한 묶음으로 묶고
-- 묶음에 포함된 데이터들의 개수를 세어서 보여주기
SELECT district, count(district)
FROM city
GROUP BY district;

-- 성적테이블에서 각 과목의 총점, 평균을 계산하여 보여주기
SELECT 과목, SUM(점수), AVG(점수)
FROM 성적테이블
GROUP BY 과목;

-- 학생별 총점과 평균 계산하여 보여주기
SELECT 학번, 이름, SUM(점수), AVG(점수)
FROM 성적테이블
GROUP BY 학번, 이름;


SELECT 학번, 이름, SUM(점수), AVG(점수)
FROM 성적테이블
GROUP BY 학번, 이름
ORDER BY 학번;

/*
city table 에서 인구(population)가 1만 이상인 도시들만
*/
SELECT * FROM city
WHERE Population >= 10000;

/*
city table 에서 인구가 1만 이상인 도시들을 인구가 많은 순서대로 조회하기
*/
SELECT * FROM city
WHERE Population >= 10000
ORDER BY Population DESC;

/*
city table 에서 인구가 1만 이상 5만 이하인 도시들의 인구 평균을 구하시오
*/
SELECT AVG(Population) 
FROM city
WHERE Population >= 10000 AND Population <= 50000;

/*
city table 에서 인구가 1만 이상 5만 이하인 도시들의 국가별(countrycode) 인구평균을 구하시오
국가별로 정렬
--통계(count(), sum(), avg(), max(), min()) 와 관련된 SQL 은 
반드시 Projection 을 수행하여 칼럼을 제한해야 한다
projection 칼럼 중에 통계함수로 묶이지 않은 칼럼은 반드시 
group by 절에서 명시해 주어야 한다 
*/
SELECT CountryCode, AVG(Population)
FROM city
WHERE Population >= 10000 AND Population <= 50000
GROUP BY CountryCode
ORDER BY CountryCode;

-- 범위를 부여하는 조건절에서 ~이상 AND ~이하 의 조건일 때 : between 
SELECT CountryCode, AVG(Population)
FROM city
WHERE Population BETWEEN 10000 AND  50000
GROUP BY CountryCode
ORDER BY CountryCode;

/*
city table 에서 각 국가별 인구 평균을 계산하고 인구 평균이 5만 이상인 국가만 조회하기

먼저 국가별 인구평균 계산하고
계산된 인구평균이 5만 이상인 경우 
avg() 함수로 게산된 결과에 조건을 부여하기 때문에
이러한 경우는 WHERE 가 아니고, HAVING 절을 GROUP BY 다음에 둔다 
*/
SELECT CountryCode, AVG(Population)
FROM city
GROUP BY CountryCode
HAVING AVG(Population) >= 50000;

/*
각 국가별(그룹을 묶어서)로 가장 인구가 많은 도시는?
*/
SELECT CountryCode, Name, MAX(Population)
FROM city
GROUP BY CountryCode
ORDER BY max(population) DESC;

