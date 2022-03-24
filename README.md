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
* 수정 버튼을 누르면 아래 댓글 입력 창에 작성자와 댓글 제목, 내용 등이 나타나고
* 내용만 고칠 수 있으며 이를 수정할 수 있다.
* 삭제는 바로 버튼을 누르면 삭제가 되게 만들어 놓았다.

추후에 고칠 부분

* REST 방식으로 수정, 삭제 구현
* 계층형 댓글 달기 REST 방식으로 구현하기

<img width="823" alt="image" src="https://user-images.githubusercontent.com/81161819/159031868-4a8deb1c-82ab-4319-98e0-8c0231218a1c.png">

<h2>3.21일 추가한 부분</h2>

* 댓글 등록, 수정, 삭제를 REST 방식으로 전환하였다.
* 삭제 버튼을 누르면 바로 삭제가 이루어지지 않고 한번 물어보는 알림 창을 추가하였다.


<img width="951" alt="image" src="https://user-images.githubusercontent.com/81161819/159293418-289d11d0-d478-4513-904e-9de625197926.png">

<img width="399" alt="image" src="https://user-images.githubusercontent.com/81161819/159293469-56a3a4f1-2a5c-486e-9424-d8d67daeb785.png">

추후에 추가할 부분

* 삭제할 때 작성자 이름을 입력하고 일치하면 삭제하는 식으로 구성하는 것이 옳은 것 같다.
* 대댓글 등록하기 하면 부모 노드의 값을 가지고 댓글이 등록되는 부분. (계층형 댓글 등록 구현)

<h2>3.22일 추가한 부분</h2>

* 계층형 댓글을 등록하는 부분을 jquery 이벤트를 통해 구현
* 취소 버튼 추가

<img width="723" alt="image" src="https://user-images.githubusercontent.com/81161819/159438829-bb911471-01c0-4483-a0f5-7f6759b234d5.png">

추후에 추가할 부분

* 삭제할 때 작성자 이름을 입력하고 일치하면 삭제하는 식으로 구성하는 것

<h2>3.24일 추가한 부분</h2>

* 삭제할 때 작성자 이름을 입력하고 일치하면 삭제하는 식으로 구성하는 것을 추가하였다.

<img width="478" alt="image" src="https://user-images.githubusercontent.com/81161819/159924498-2916c91e-db78-4c37-b6c0-c8fae9d04999.png">

느낀 점
* 이런식으로 다른 게시판+ 관련 프로젝트에서 무한스크롤 기능까지 추가하면 좋을 것 같다.
* 대댓글이 달린 댓글들을 숨기고 버튼 표시를 하여 누르면 대댓글이 열리는 그런 부분을 추가하면 좋을 것 같다.
