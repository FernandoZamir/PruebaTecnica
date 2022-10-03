// Please see documentation at https://docs.microsoft.com/aspnet/core/client-side/bundling-and-minification
// for details on configuring this project to bundle and minify static web assets.

// Write your JavaScript code.


$(document).ready(function () {

    // Materia 
    $("#btnCrearMateria").click(function () {
        $("#CrearMateria").modal("show");
    });

    $("#btnCerrarMateria").click(function () {
        $("#CrearMateria").modal("hide");
    });

    $("#btnCrearActualizarMateria").click(function () {
        CrearActualizarMateria();
    });

    //function ListarMateria() {
    //    $.ajax({
    //        url: "/Materia/Listar",
    //        dataType: 'json',
    //        type: 'GET',
    //        success: function (data) {
               
    //            //if (data['tipo_error'] == "EXITO") {
    //            //    alert(data['mensaje'])
    //            //    $("#CrearMateria").modal("hide");
    //            //}
    //        }
    //    });    
    //}

    function CrearActualizarMateria() {
        var titulo = document.getElementById('TituloInput').value;
        var descripcion = document.getElementById('DescripcionTextarea').value;

        if (titulo == "") {
            alert("El titulo de la materia no pyuede ser vacio");
        } else if (descripcion == "") {
            alert("La descripción de la materia no pyuede ser vacia");
        } else {
            $.ajax({
                url: "/Materia/CrearActualizar",
                dataType: 'json',
                type: 'POST',
                data: { titulo, descripcion },
                success: function (data) {
                    let jsonResp = data[0];
                   
                    if (jsonResp['tipo_error'] == "EXITO") {
                        alert(jsonResp['mensaje'])
                        $("#CrearMateria").modal("hide");
                    }                   
                }
            });
        }
    }

    // Estudiante
    $("#btnCrearEstudiante").click(function () {
        $("#CrearEstudiante").modal("show");
    });

    $("#btnCerrarEstudiante").click(function () {
        $("#CrearEstudiante").modal("hide");
    });

    $("#btnCrearActualizarEstudiante").click(function () {
        CrearActualizarEstudiante();
    });

    function CrearActualizarEstudiante() {
        var identificacion = document.getElementById('IdentificacionInput').value;
        var primerNombre = document.getElementById('PrimerNombreInput').value;
        var segundoNombre = document.getElementById('SegundoNombreInput').value;
        var primerApellido = document.getElementById('PrimerApellidoInput').value;
        var segundoApellido = document.getElementById('SegundoApellidoInput').value;
        var genero = document.getElementById('GeneroInput').value;
        var fechaNacimiento = document.getElementById('FechaNacimientoInput').value;
        var tipoSangre = document.getElementById('TipoSangreInput').value;
        var residencia = document.getElementById('ResidenciaInput').value;
        var telefonoRepresentante = document.getElementById('TelefonoRepresenanteInput').value;
        var estado = document.getElementById('EstadoInput').value;

        if (identificacion == "") {
            alert("La identificacion del estudiante no puede estar sin datos.");
        } else if (primerNombre == "") {
            alert("El nombre del estudiante no puede estar sin datos");
        }
        else if (primerApellido == "") {
            alert("El primer apellido del estudiante no puede estar sin datos");
        }
        else if (segundoApellido == "") {
            alert("El segundo apellido del estudiante no puede estar sin datos");
        }
        else if (fechaNacimiento == "") {
            alert("El primer apellido del estudiante no puede estar sin datos");
        }

        else {
            $.ajax({
                url: "/Estudiante/CrearActualizar",
                dataType: 'json',
                type: 'POST',
                data: {
                    identificacion, primerNombre, segundoNombre, primerApellido, segundoApellido, genero, fechaNacimiento, tipoSangre, residencia, telefonoRepresentante, estado
                },
                success: function (data) {
                    let jsonResp = data[0];
                    if (jsonResp['tipo_error'] == "EXITO") {
                        alert(jsonResp['mensaje'])
                        $("#CrearEstudiante").modal("hide");
                    }
                }
            });
        }
    }

    // Notas
    $("#btnCrearNota").click(function () {
        $("#CrearNota").modal("show");
    });

    $("#btnCerrarNota").click(function () {
        $("#CrearNota").modal("hide");
    });

    $("#btnCrearActualizarNota").click(function () {
        CrearActualizarNota();
    });

    function CrearActualizarNota() {
        var idEstudiante = document.getElementById('TituloInput').value;
        var idMateria = document.getElementById('TituloInput').value;
        var nota = document.getElementById('DescripcionTextarea').value;

        if (idEstudiante == "") {
            alert("El id del estudiante no puede ser vacio.");
        } else if (idMateria == "") {
            alert("El id de la materia no puede ser vacia.");
        } else {
            $.ajax({
                url: "/Materia/CrearActualizar",
                dataType: 'json',
                type: 'POST',
                data: { idEstudiante, idMateria, nota },
                success: function (data) {
                    let jsonResp = data[0];

                    if (jsonResp['tipo_error'] == "EXITO") {
                        alert(jsonResp['mensaje'])
                        $("#CrearMateria").modal("hide");
                    }
                }
            });
        }
    }
});