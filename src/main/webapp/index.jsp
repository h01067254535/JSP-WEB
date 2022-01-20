<%@ page language="java" contentType="text/html; charset=EUC-KR"
	pageEncoding="EUC-KR"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page import="user.UserDAO"%>
<!DOCTYPE html>
<html>
<head>
<!-- Required meta tags -->
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

<!-- Bootstrap CSS -->
<link rel="stylesheet"
	href="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/css/bootstrap.min.css"
	integrity="sha384-Gn5384xqQ1aoWXA+058RXPxPg6fy4IWvTNh0E263XmFcJlSAwiGgFAW/dAiS6JXm"
	crossorigin="anonymous">

<title>������</title>
</head>
<body>

	<%
	String userID = null;
	if (session.getAttribute("userID") != null) { //�α��� �� ���¸�
		userID = (String) session.getAttribute("userID");
	}
	if (userID == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('�α����� ���ּ���.');");
		script.println("location.href = 'userLogin.jsp';"); //�̸��� ���� 
		script.println("</script>");
		script.close();
		return;
	}
	boolean emailChecked = new UserDAO().getUserEmailChecked(userID);
	if (emailChecked == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("location.href = 'emailSendConfirm.jsp';"); //�̸��� ���� 
		script.println("</script>");
		script.close();
		return;
	}
	%>

	<nav class="navbar navbar-expand-lg navbar-light bg-light">
		<a class="navbar-brand" href="index.jsp">������ �� ����Ʈ</a>
		<button class="navbar-toggler" type="button" data-toggle="collapse"
			data-target="#navbarSupportedContent"
			aria-controls="navbarSupportedContent" aria-expanded="false"
			aria-label="Toggle navigation">
			<span class="navbar-toggler-icon"></span>
		</button>

		<div class="collapse navbar-collapse" id="navbarSupportedContent">
			<ul class="navbar-nav mr-auto">
				<li class="nav-item"><a class="nav-link" href="index.jsp">����
						<span class="sr-only">(current)</span>
				</a></li>
				<li class="nav-item dropdown"><a
					class="nav-link dropdown-toggle" href="index.jsp"
					id="navbarDropdown" role="button" data-toggle="dropdown"
					aria-haspopup="true" aria-expanded="false"> ȸ�� ���� </a>
					<div class="dropdown-menu" aria-labelledby="navbarDropdown">
						<%
						if (userID == null) { //�α����� �ȵǾ�������, �α��ΰ� ȸ�����Ը� ����.
						%>
						<a class="dropdown-item" href="userLogin.jsp">�α���</a> <a
							class="dropdown-item" href="userJoin.jsp">ȸ������</a>
						<%
						} else {
						%>
						<a class="dropdown-item" href="userLogout.jsp">�α׾ƿ�</a>

						<%
						}
						%>
					</div></li>
			</ul>
			<form class="form-inline my-2 my-lg-0">
				<input class="form-control mr-sm-2" type="search"
					placeholder="������ �Է��ϼ���." aria-label="Search">
				<button class="btn btn-outline-success my-2 my-sm-0" type="submit">�˻�</button>
			</form>
		</div>
	</nav>
	<section class="container">
		<form method="get" action="./index.jsp" class="form-inline mt-3">
			<select name="LectureDivide" class="form-control mx-1 mt-2">
				<option value="��ü">��ü</option>
				<option value="����">����</option>
				<option value="����">����</option>
				<option value="��Ÿ">��Ÿ</option>
			</select> <input type="text" name="search" class="form-control mx-1 mt-2"
				placeholder="������ �Է��ϼ���.">
			<button type="submit" class="btn btn-primary mx-1 mt-2">�˻�</button>
			<a class="btn btn-primary mx-1 mt-2" data-toggle="modal"
				href="#registerModal">����ϱ�</a> <a class="btn btn-danger mx-1 mt-2"
				data-toggle="modal" href="#reportModal">�Ű�</a>
		</form>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">
						��ǻ�Ͱ���&nbsp;<small>�Ѻ���</small>
					</div>
					<div class="col-4 text-right">
						����<span style="color: red;">A</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					���� ���� ���ǿ���.&nbsp;<small>(2017�� �����б�)</small>
				</h5>
				<p class="card-text">���ǰ� ���� �γ��ؿ�.</p>
				<div class="row">
					<div class="col-9 text-left">
						���� <span style="color: red;">A</span> �γ� <span style="color: red;">A</span>
						���� <span style="color: red;">B</span> <span style="color: green;">(��õ:
							15)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('��õ�Ͻðڽ��ϱ�?')"
							href="./likeAction.jsp?evaluationID=">��õ</a> <a
							onclick="return confirm('�����Ͻðڽ��ϱ�?')"
							href="./deleteAction.jsp?evaluationID=">����</a>

					</div>

				</div>

			</div>
		</div>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">
						��ǻ�Ͱ���&nbsp;<small>�Ѻ���</small>
					</div>
					<div class="col-4 text-right">
						����<span style="color: red;">A</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					���� ���� ���ǿ���.&nbsp;<small>(2017�� �����б�)</small>
				</h5>
				<p class="card-text">���ǰ� ���� �γ��ؿ�.</p>
				<div class="row">
					<div class="col-9 text-left">
						���� <span style="color: red;">A</span> �γ� <span style="color: red;">A</span>
						���� <span style="color: red;">B</span> <span style="color: green;">(��õ:
							15)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('��õ�Ͻðڽ��ϱ�?')"
							href="./likeAction.jsp?evaluationID=">��õ</a> <a
							onclick="return confirm('�����Ͻðڽ��ϱ�?')"
							href="./deleteAction.jsp?evaluationID=">����</a>

					</div>

				</div>

			</div>
		</div>
		<div class="card bg-light mt-3">
			<div class="card-header bg-light">
				<div class="row">
					<div class="col-8 text-left">
						��ǻ�Ͱ���&nbsp;<small>�Ѻ���</small>
					</div>
					<div class="col-4 text-right">
						����<span style="color: red;">A</span>
					</div>
				</div>
			</div>
			<div class="card-body">
				<h5 class="card-title">
					���� ���� ���ǿ���.&nbsp;<small>(2017�� �����б�)</small>
				</h5>
				<p class="card-text">���ǰ� ���� �γ��ؿ�.</p>
				<div class="row">
					<div class="col-9 text-left">
						���� <span style="color: red;">A</span> �γ� <span style="color: red;">A</span>
						���� <span style="color: red;">B</span> <span style="color: green;">(��õ:
							15)</span>
					</div>
					<div class="col-3 text-right">
						<a onclick="return confirm('��õ�Ͻðڽ��ϱ�?')"
							href="./likeAction.jsp?evaluationID=">��õ</a> <a
							onclick="return confirm('�����Ͻðڽ��ϱ�?')"
							href="./deleteAction.jsp?evaluationID=">����</a>

					</div>

				</div>

			</div>
		</div>
	</section>

	<div class="modal" id="registerModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">�� ���</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./evaluationRegisterActions.jsp" method="post">
						<div class="form-row">
							<div class="form-group col-sm-6">
								<label>���Ǹ�</label> <input type="text" name="LectureName"
									class="form-control" maxlength="20" />
							</div>
							<div class="form-group col-sm-6">
								<label>������</label> <input type="text" name="ProfessorName"
									class="form-control" maxlength="20" />
							</div>
						</div>
						<div class="form-row">
							<!-- �Ѱ��� ���� 12ĭ�� ������, �Ʒ� class 4�� ���� -->
							<div class="form-group col-sm-4">
								<label>���� ����</label> <select name="LectureYear"
									class="form-control">
									<option value="2017">2017</option>
									<option value="2018">2018</option>
									<option value="2019">2019</option>
									<option value="2020">2020</option>
									<option value="2021">2021</option>
									<option value="2022" selected>2022</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>���� �б�</label> <select name="SemesterDivide"
									class="form-control">
									<option value="1�б�" selected>1�б�</option>
									<option value="�����б�">�����б�</option>
									<option value="2�б�">2�б�</option>
									<option value="�ܿ��б�">�ܿ��б�</option>
								</select>
							</div>
							<div class="form-group col-sm-4">
								<label>���� ����</label> <select name="LectureDivide"
									class="form-control">
									<option value="����" selected>����</option>
									<option value="����">����</option>
									<option value="��Ÿ">��Ÿ</option>
								</select>
							</div>
						</div>
						<div class="form-group">
							<label>����</label> <input type="text" name="EvaluationTime"
								class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>����</label>
							<textarea name="EvaluationContent" class="form-control"
								maxlength="2048" style="height: 180px;"></textarea>
						</div>
						<div class="form-row">
							<div class="form-group col-sm-3">
								<label>����</label> <select name="TotalScore" class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>����</label> <select name="CreditScore"
									class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>�γ�</label> <select name="ComfortableScore"
									class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
							<div class="form-group col-sm-3">
								<label>����</label> <select name="LectureScore"
									class="form-control">
									<option value="A" selected>A</option>
									<option value="B">B</option>
									<option value="C">C</option>
									<option value="D">D</option>
									<option value="F">F</option>
								</select>
							</div>
						</div>
					</form>
				</div>
				<div class="modal-footer">

					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">���</button>
					<button type="submit" class="btn btn-primary">����ϱ�</button>

				</div>
			</div>
		</div>
	</div>
	<div class="modal" id="reportModal" tabindex="-1" role="dialog">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title">�Ű��ϱ�</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">&times;</span>
					</button>
				</div>
				<div class="modal-body">
					<form action="./reportActions.jsp" method="post">

						<div class="form-group">
							<label>�Ű�����</label> <input type="text" name="ReportTitle"
								class="form-control" maxlength="30">
						</div>
						<div class="form-group">
							<label>�Ű���</label>
							<textarea name="ReportContect" class="form-control"
								maxlength="2048" style="height: 180px;"></textarea>
						</div>
					</form>
				</div>
				<div class="modal-footer">

					<button type="button" class="btn btn-secondary"
						data-dismiss="modal">���</button>
					<button type="submit" class="btn btn-danger">�Ű��ϱ�</button>

				</div>
			</div>
		</div>
	</div>
	<jsp:include page="/WEB-INF/views/footer.jsp" />

	<script src="https://code.jquery.com/jquery-3.2.1.slim.min.js"
		integrity="sha384-KJ3o2DKtIkvYIK3UENzmM7KCkRr/rE9/Qpg6aAZGJwFDMVNA/GpGFF93hXpG5KkN"
		crossorigin="anonymous"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.12.9/umd/popper.min.js"
		integrity="sha384-ApNbgh9B+Y1QKtv3Rn7W3mgPxhU9K/ScQsAP7hUibX39j7fakFPskvXusvfa0b4Q"
		crossorigin="anonymous"></script>
	<script
		src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"
		integrity="sha384-JZR6Spejh4U02d8jOt6vLEHfe/JQGiRRSQQxSfFWpi1MquVdAyjUar5+76PVCmYl"
		crossorigin="anonymous"></script>
</body>
</html>