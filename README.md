# 프로젝트 설명
### 대댓글 프로젝트

#### 댓글관리
- [X] 댓글을 작성할 수 있어야 한다.
- [X] 댓글 목록을 볼 수 있어야 한다.
- [X] 개별 댓글을 확인할 수 있어야 한다.
- [X] 댓글을 수정할 수 있어야 한다.
- [X] 댓글을 삭제할 수 있어야 한다.

# 사용한 기술
- <b>JDK 1.8</b>
- <b>Spring Legacy</b>
- <b>HikariCP 2.7.4</b>
- <b>mybatis 3.4.6</b>
- <b>Oracle</b>

# Project Structure
```
 ─src
   └─ main
      ├─ java
      │  └─ org
      │      └─ zerock
      │          ├─ controller // 컨트롤러
      │          ├─ domain // VO
      │          ├─ mapper // 댓글 Mapper
      │          ├─ service // 서비스 (비즈니스 로직)
      │          └─ sql // SQL
      ├─ resources
      │  ├─ META-INF
      │  └─ org
      │      └─ zerock
      │          └─ mapper // Mybatis 연동을 위한 xml
      └─ webapp
          ├─ resources
          │  └─ js
          └─ WEB-INF
              ├─ classes
              ├─ spring
              │  └─ appServlet
              └─ views // .jsp 화면 페이지

```

# ERD
- 실제로 게시판 테이블은 생성하지 않았고, 게시판과 연동했을때 이러한 구조가 나옵니다.
<img width="652" alt="image" src="https://user-images.githubusercontent.com/81161819/226182406-570e3c77-a76d-4d17-a033-a246194e5955.png">

# API
## Reply
- 댓글 작성 `(POST /replies/new)`
- 댓글 목록 보기 `(GET /replies/comment)`
- 개별 댓글 보기 `(GET /replies/{bid})`
- 댓글 수정 `(PUT/PATCH /replies/{bid})`
- 댓글 삭제 `(PUT /replies/{bid})`

# ISSUE, WORKFLOW
## Rest API 리팩토링

현재 컨트롤러는 Rest API 방식이 아니였습니다. 
### 컨트롤러 Example
```java
@Controller
public class ReplyController {
	/* 빈 주입 */
	@RequestMapping(value="/register", method = RequestMethod.POST)
	public String register(ReplyVO vo) {
	    /* 댓글 저장 후 메인페이지 */
	}
	@RequestMapping(value = "/update", method = RequestMethod.POST)
	public String update(ReplyVO vo) {
	    /* 수정 후 메인페이지 */
	}
```

Rest 방식으로 구현하기 위해 `RestController` 어노테이션을 붙여 리팩토링 하였습니다.
### RestController Example
```java
@RestController
public class RestReplyController {
	@PostMapping(value="/new",
				 consumes = "application/json",
				 produces = {MediaType.TEXT_PLAIN_VALUE})
	public ResponseEntity<String>create(@RequestBody ReplyVO vo){
		/* 댓글 저장 */
	}
}
```

## 계층형 쿼리
대댓글을 구현하려면 계층형 쿼리를 구현해야 했습니다.
```xml
<select id="replyList" resultType="org.zerock.domain.ReplyVO">
	SELECT * FROM MVC_BOARD
	START WITH BSTEP=0
	CONNECT BY PRIOR BID  = BSTEP  
	ORDER SIBLINGS BY BSTEP  asc, BID desc
</select>
```
- BID가 댓글이 달리면 계속 증가하는 `ID`라고 보면 됩니다. 
- BSTEP은 BID를 가리키게 되는데, 이를 통해 계층형 쿼리를 작성할 수 있습니다.
- BSTEP은 0을 가진 BID를 찾게 되어 자식 댓글을 찾게 됩니다.
- 찾은 후 BSTEP을 기준으로 오름차순, BID 기준으로 내림차순을 하게 되는데 이는 BID 오름차순을 통해 최신 댓글이 위에 오게 되고, BSTEP을 기준으로 오름차순하면 나중에 쓴 댓글이 아래 달리게 됩니다.

### SQL Example

```sql
CREATE TABLE mvc_board( 
	bid number(4) PRIMARY KEY,  -- 댓글 PRIMARY KEY 
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

## 댓글 화면 & 프로젝트 변경 사항
<img width="576" alt="image" src="https://user-images.githubusercontent.com/81161819/157805898-afec7fe9-9981-465f-aab1-0528b9e93959.png">

### 추가한 부분

* 댓글 목록을 REST로 불러오는 부분과, 계층적인 부분을 구현.

<img width="375" alt="image" src="https://user-images.githubusercontent.com/81161819/157805605-3ba94147-2996-491c-8d56-5c1e615eecd8.png">

### 추가한 부분

* 댓글 수정과 삭제를 REST 방식이 아닌 Ajax를 통해 비동기적으로 구현해
* 수정 버튼을 누르면 아래 댓글 입력 창에 작성자와 댓글 제목, 내용 등이 나타나고
* 내용만 고칠 수 있으며 이를 수정 가능
* 삭제는 바로 버튼을 누르면 삭제가 되게 만들어 놓았습니다.

추후에 고칠 부분

* REST 방식으로 수정, 삭제 구현
* 계층형 댓글 달기 REST 방식으로 구현하기

<img width="823" alt="image" src="https://user-images.githubusercontent.com/81161819/159031868-4a8deb1c-82ab-4319-98e0-8c0231218a1c.png">

### 추가한 부분

* 댓글 등록, 수정, 삭제를 REST 방식으로 전환
* 삭제 버튼을 누르면 바로 삭제가 이루어지지 않고 한번 물어보는 알림 창을 추가


<img width="951" alt="image" src="https://user-images.githubusercontent.com/81161819/159293418-289d11d0-d478-4513-904e-9de625197926.png">

<img width="399" alt="image" src="https://user-images.githubusercontent.com/81161819/159293469-56a3a4f1-2a5c-486e-9424-d8d67daeb785.png">

추후에 추가할 부분

* 삭제할 때 작성자 이름을 입력하고 일치하면 삭제하는 식으로 구성하는 것이 옳은 것 같다.
* 대댓글 등록하기 하면 부모 노드의 값을 가지고 댓글이 등록되는 부분. (계층형 댓글 등록 구현)

### 추가한 부분

* 계층형 댓글을 등록하는 부분을 jquery 이벤트를 통해 구현
* 취소 버튼 추가

<img width="723" alt="image" src="https://user-images.githubusercontent.com/81161819/159438829-bb911471-01c0-4483-a0f5-7f6759b234d5.png">

추후에 추가할 부분

* 삭제할 때 작성자 이름을 입력하고 일치하면 삭제하는 식으로 구성하는 것

### 추가한 부분

* 삭제할 때 작성자 이름을 입력하고 일치하면 삭제하는 식으로 구성하는 것을 추가하였다.

<img width="478" alt="image" src="https://user-images.githubusercontent.com/81161819/159924498-2916c91e-db78-4c37-b6c0-c8fae9d04999.png">

# 느낀 점
* 이런식으로 다른 게시판+ 관련 프로젝트에서 무한스크롤 기능까지 추가하면 좋을 것 같다.
* 대댓글이 달린 댓글들을 숨기고 버튼 표시를 하여 누르면 대댓글이 열리는 그런 부분을 추가하면 좋을 것 같다.
