<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<link rel="shortcut icon" type="image/png" href="IMG/airplane(1).png">
<title>Escalas - AeroLine</title>
</head>
<link rel="stylesheet" href="CSS/estilostablas.css">
<script src="http://code.jquery.com/jquery-latest.js"></script>
<script src="//cdn.jsdelivr.net/npm/sweetalert2@11"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.3/css/all.min.css">
<body>
<script type="text/javascript">$(document).ready(function () {
		$("#Cerrar").click(function (){
			Swal.fire({
				  title: 'Cierre de Sesion',
				  text: "�Esta seguro que desea cerrar sesion?",
				  icon: 'question',
				  showCancelButton: true,
				  confirmButtonColor: '#3085d6',
				  cancelButtonColor: '#d33',
				  confirmButtonText: 'Si',
				  cancelButtonText: 'Cancelar',
				  backdrop: `
					    rgba(0,0,123,0.4)
					    left top
					    no-repeat
					  `
				}).then((result) => {
					if (result.isConfirmed) {
						  Swal.fire({
							  title: 'Cerrando Sesion...',
							  html: 'Espere unos instantes',
							  timer: 3000,
							  showConfirmButton: false,
							  timerProgressBar: true,
							  backdrop: `
								    rgba(0,0,123,0.4)
								    left top
								    no-repeat
								  `,
							  didOpen: () => {
							    Swal.showLoading()
							  },
							}).then((result) => {
								var btncerrar = "Cerrar";
								$.post('ControllerAcceso', {
									//Enviando variable al controlador.
									btncerrar
									},
									function (response) {
								location.href = 'http://localhost:8080/sistemaAeropuerto/index.jsp';
									});
							})
						  	
					 }
			})
		})
	})
	</script>
<%
HttpSession sesion = (HttpSession) request.getSession();
String usuSession = String.valueOf(sesion.getAttribute("usuario"));

if (usuSession.equals(null) || usuSession.equals("null")) {

	response.sendRedirect("index.jsp");
}
%>
	
<%
String IdVuelo = request.getParameter("IdVuelo");
%>
<script type="text/javascript">
				$(document).ready(function () {
					
					var IdVuelo = <%=IdVuelo%>
					$.post('ControllerEscala', {
						IdVuelo
					}, function (response) {
						let datos = JSON.parse(response);

						console.log(datos);

						var tabla = document.getElementById('tablaEscalas');
						for (let item of datos) {
							if(item.estado == 0){
								tabla.innerHTML += `
									<tr>
										<td>${item.idEscala}</td>
										<td>${item.numeroEscala}</td>
										<td>$${item.Precio}</td>
										<td>${item.nombre}</td>
										<td>Opciones no disponibles</td>
									</tr>
									`
							}else{
								tabla.innerHTML += `
									<tr>
										<td>${item.idEscala}</td>
										<td>${item.numeroEscala}</td>
										<td>$${item.Precio}</td>
										<td>${item.nombre}</td>
										<td><button class="btntableeliminar"><a class="atableeliminar" href="ControllerEscala?IdEscala=${item.idEscala}&numeroEscala=${item.numeroEscala}&idVuelo=<%=IdVuelo%>&Eliminar=btne"><i class="far fa-trash-alt fa-2x" style="color: black;"></i></a></button>
										<button class="btntableupdate"><a class="atableupdate" href="addescala.jsp?Id=${item.idEscala}&Precio=${item.Precio}&nombre=${item.nombre}&IdAeropuerto=${item.idAeropuerto}&numeroEscala=${item.numeroEscala}&IdVuelo=<%=IdVuelo %>"> <i class="fas fa-edit fa-2x " style="color: black;"></i></a></button>
										</td>
									</tr>
									`
							}
						}
					});
				});
				
				$(document).ready(function () {
					$("#Agregar").click(function (){
							location.href = 'http://localhost:8080/sistemaAeropuerto/addescala.jsp?IdVuelo=<%=IdVuelo %>';
					});
				});						
</script>

<header>
	<input type="checkbox" id="btn-menu">
	<label for="btn-menu"><img alt="" src="IMG/menu.png" height="30px" width="30px"></label>
		
		<nav class="menu">
			<ul>
				<li><a href="menu.jsp">Inicio</a></li>
				<li><a href="aeropuerto.jsp">Aeropuertos</a></li>
				<li><a href="company.jsp">Compa�ias</a></li>
				<li><a href="avion.jsp">Aviones</a></li>
				<li><a href="tipos.jsp">Tipos de Vuelo</a></li>
				<li><a href="vuelo.jsp">Vuelos</a></li>
				<li><a href="#" id="Cerrar">Cerrar Sesion</a></li>
			</ul>
	</nav>
	</header>

	<div class="containertabla">
		<img class="icono" src="IMG/icono-avion-viaje_18591-39662.jpg"
			alt="Logo avion">
		<h1 align="center">Escalas</h1>
		<table>
			<thead>
				<th>Id Escala</th>
				<th>N Escala</th>
				<th>Precio</th>
				<th>Aeropuerto</th>
				<th>Acciones</th>
			</thead>
			<tbody id="tablaEscalas">

			</tbody>
		</table>
		<div align="center">
			<button class="agregar" id="Agregar"><b>Agregar</b></button>
		</div>
	</div>
</body>
</html>