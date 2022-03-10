<h2>계층형 댓글 프로젝트</h2>

-> 간단하게 댓글 테이블만 구성해보았습니다<br>
- Eclipse, jdk 1.8
- db : oracleDB<br><br>
- 사용 라이브러리
1. log4j 1.2.17
2. javax.servlet-api 3.1.0
3. lombok 1.18.0
4. HikariCP 2.7.4
5. mybatis 3.4.6
6. mybatis-spring 1.3.2
7. spring-tx 
8. spring-jdbc
9. log4jdbc-log4j2-jdbc4 1.16
10. spring-test
11. jUnit 4.12

<h3>SQL</h3>
```
CREATE TABLE mvc_board(
	bid number(4) PRIMARY KEY,  -- 게시판 PRIMARY KEY 
	bname varchar2(20),   -- 작성자
	btitle varchar2(100), -- 글 제목
	bcontent varchar2(300), -- 글 내용
	bdate DATE DEFAULT sysdate, -- 등록일자
	bhit number(4) DEFAULT 0, -- 조회수 
	bgroup number(4), -- 트리구조 최상위(ROOT)
	bstep number(4), -- 트리구조에서 자신의 상위 노드(Parent Node)
	bindent number(4) -- 트리구조의 레벨
);
```
