<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style type="text/css">
.tree{
  margin-top: 5px;
}
.tree, .tree ul{
  list-style: none; /* 기본 리스트 스타일 제거 */
  padding-left:10px;
}
.tree *:before{
  width:15px;
  height:15px;
  display:inline-block;
}
.tree label{
  cursor: pointer;
  font-family: NotoSansKrMedium, sans-serif !important;
  font-size: 14px;
  color: #0055CC;
}
.tree label:hover{
  color: #00AACC;
}
.tree label:before{
  content: '+'
}
.tree label.lastTree:before{
  content:'o';
}
.tree label:hover:before{
  content: '+'
}
.tree label.lastTree:hover:before{
  content:'o';
}
.tree input[type="checkbox"] {
  display: none;
}
.tree input[type="checkbox"]:checked~ul {
  display: none;
}
.tree input[type="checkbox"]:checked+label:before{
  content: '-'
}
.tree input[type="checkbox"]:checked+label:hover:before{
  content: '-'
}

.tree input[type="checkbox"]:checked+label.lastTree:before{
  content: 'o';
}
.tree input[type="checkbox"]:checked+label.lastTree:hover:before{
  content: 'o';
}
</style>
</head>
<body>
<ul class="tree">
  <li>
    <input type="checkbox" id="root">
    <label for="root">ROOT</label>
    <ul>
      <li>
        <input type="checkbox" id="node1">
        <label for="node1" class="lastTree">node1</label>
      </li>
      <li>
        <input type="checkbox" id="node2">
        <label for="node2">node2</label>
        <ul>
          <li>
            <input type="checkbox" id="node21">
            <label for="node21" class="lastTree">node21</label>
          </li>
        </ul>
      <li>
        <input type="checkbox" id="node3">
        <label for="node3">node3</label>
        <ul>
          <li>
            <input type="checkbox" id="node31">
            <label for="node31" class="lastTree">node31</label>
          </li>
          <li>
            <input type="checkbox" id="node32">
            <label for="node32">node32</label>
            <ul>
              <li>
                <input type="checkbox" id="node321">
                <label for="node321" class="lastTree">node321</label>
              </li>
              <li>
                <input type="checkbox" id="node322">
                <label for="node322" class="lastTree">node322</label>
              </li>
              <li>
                <input type="checkbox" id="node323">
                <label for="node323" class="lastTree">node323</label>
              </li>
            </ul>
          <li>
            <input type="checkbox" id="node33">
            <label for="node33" class="lastTree">node33</label>
          </li>
        </ul>
      </li>
    </ul>
  </li>
</ul>
</body>
</html>