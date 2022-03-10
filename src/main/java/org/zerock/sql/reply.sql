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


SELECT * FROM MVC_BOARD
START WITH BSTEP=0
CONNECT BY PRIOR BID  = BSTEP  
ORDER SIBLINGS BY BSTEP  asc, BID desc;
