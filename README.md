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

<h3>1. SQL</h3>

```sql
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

<h3>2. replyMapper와 replyMapper.xml</h3>

```java
public interface ReplyMapper {
	public int insert(ReplyVO vo);
	public List<ReplyVO> replyList(); 
}
```
<img width="607" alt="image" src="https://user-images.githubusercontent.com/81161819/157589049-1e9294a2-0fc4-429f-bbb0-05981815177f.png">
- replyMapper Test코드 작성 : O<br>
https://github.com/beginner0107/replyProject/blob/master/src/test/java/org/zerock/mapper/ReplyMapperTest.java
<h3>3. replyService </h3>

```java
public interface ReplyService {
	public List<ReplyVO> getList();
}
```
- replyService Test코드 작성 : O
https://github.com/beginner0107/replyProject/tree/master/src/test/java/org/zerock/service
<h3>4. replyController </h3>

```java
@Controller
public class ReplyController {
	
	@Setter(onMethod = @__(@Autowired))
	private ReplyService service;
	
	@RequestMapping(value = "/", method = RequestMethod.GET)
	public String home(Locale locale, Model model) {
		
		model.addAttribute("list", service.getList());
		
		return "home";
	}
	
}
```
- ReplyController Test코드 작성 : O<br>

https://github.com/beginner0107/replyProject/blob/master/src/test/java/org/zerock/controller/ReplyControllerTests.java
<h3>댓글 화면</h3>
<img width="576" alt="image" src="https://user-images.githubusercontent.com/81161819/157805898-afec7fe9-9981-465f-aab1-0528b9e93959.png">

<h2>3.11일 추가한 부분</h2>

* 댓글 목록을 REST로 불러오는 부분과, 계층적인 부분을 구현.

<img width="375" alt="image" src="https://user-images.githubusercontent.com/81161819/157805605-3ba94147-2996-491c-8d56-5c1e615eecd8.png">

<h2>3.19일 추가한 부분</h2>
코로나 이슈로 잠깐 끊겼었다.

* 댓글 수정과 삭제를 REST 방식이 아닌 Ajax를 통해 비동기적으로 구현해보았다. 

추후에 고칠 부분

* REST 방식으로 수정, 삭제 구현
* 계층형 댓글 달기 REST 방식으로 구현하기

<img width="823" alt="image" src="https://user-images.githubusercontent.com/81161819/159031868-4a8deb1c-82ab-4319-98e0-8c0231218a1c.png">

