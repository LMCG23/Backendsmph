using Business.Models;
using Business.Services;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using static Business.Utilities.Functions;

namespace ControlClaro.Controllers
{
    public class ComplainController : ApiController
    {

        [HttpGet]
        [Route("api/queja/lista")]
        public HttpResponseMessage ListaDepartamentos()
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);

             

                using (ComplainService service = new ComplainService())
                {

                    
                    var departamentos = service.TodosDespartamentos();
                    data.result = new { departamentos };
                    data.status = true;
                }
            }
            catch (Exception ex)
            {
                response.StatusCode = config.isAuthenticated ? HttpStatusCode.BadRequest : HttpStatusCode.Unauthorized;
                data.status = false;
                data.message = ex.Message;
                data.error = NewError(ex, "Lista de Departamentos");
            }
            finally
            {
                response.Content = CreateContent(data);
            }

            return response;
        }

        [HttpGet]
        [Route("api/complaints/list/{desde}/{hasta}/{state}/{department}")]
        public HttpResponseMessage complaintsFilter(string desde,string hasta,string state,string department)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);

                if (desde == "_ALL_")
                {
                    desde = "";
    }

                if (hasta == "_ALL_")
                {
                    hasta = "";
                }

                if (state == "_ALL_")
                {
                    state = "";
                }

                if (department == "_ALL_")
                {
                    department = "";
                }


                using (ComplainService service = new ComplainService())
                {
                    var complaints = service.complaintsFilter(desde, hasta, state, department,config.usuario.usuario_Id);
                    data.result = new { complaints };
                    data.status = true;
                }
            }
            catch (Exception ex)
            {
                response.StatusCode = config.isAuthenticated ? HttpStatusCode.BadRequest : HttpStatusCode.Unauthorized;
                data.status = false;
                data.message = ex.Message;
                data.error = NewError(ex, "Lista de quejas");
            }
            finally
            {
                response.Content = CreateContent(data);
            }

            return response;
        }




        [HttpGet]
        [Route("api/Funcionario/listaFuncionarios/{depSeleccion}")]
        public HttpResponseMessage ListaFuncionarios( string depSeleccion)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);



                using (ComplainService service = new ComplainService())
                {
                    var funcionarios = service.TodosFuncionarios(depSeleccion);
                    data.result = new { funcionarios };
                    data.status = true;
                }
            }
            catch (Exception ex)
            {
                response.StatusCode = config.isAuthenticated ? HttpStatusCode.BadRequest : HttpStatusCode.Unauthorized;
                data.status = false;
                data.message = ex.Message;
                data.error = NewError(ex, "Lista de Funcionarios");
            }
            finally
            {
                response.Content = CreateContent(data);
            }

            return response;
        }



        [HttpPost]
        [Route("api/queja/GuardarQueja/{queja}")]
        public HttpResponseMessage PostFile(Complain queja)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);

                using (ComplainService service = new ComplainService())
                {
                    service.GuardarQueja(queja.Description,queja.state, queja.person_Id, queja.User_id, queja.employee_name, queja.employee, queja.department_id,queja.fecha);
                    data.result = null;
                    data.status = true;
                    data.message = "Su queja ha sido enviada correctamente";
                }
            }
            catch (Exception ex)
            {
                response.StatusCode = config.isAuthenticated ? HttpStatusCode.BadRequest : HttpStatusCode.Unauthorized;
                data.status = false;
                data.message = ex.Message;
                data.error = NewError(ex, "Error en la creación de la queja");
            }
            finally
            {
                response.Content = CreateContent(data);
            }

            return response;
        }


        [HttpGet]
        [Route("api/Complain/List/{Id_User}")]
        public HttpResponseMessage ListComplainsbyId(int Id_User)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);



                using (ComplainService service = new ComplainService())
                {
                    var complains = service.ListComplainsbyId(Id_User);
                    data.result = new { complains}; 
                    data.status = true;
                }
            }
            catch (Exception ex)
            {
                response.StatusCode = config.isAuthenticated ? HttpStatusCode.BadRequest : HttpStatusCode.Unauthorized;
                data.status = false;
                data.message = ex.Message;
                data.error = NewError(ex, "Lista de Quejas");
            }
            finally
            {
                response.Content = CreateContent(data);
            }

            return response;
        }

        [HttpPost]
        [Route("api/complain/Update/")]
        public HttpResponseMessage UpdateComplain([FromBody] Complain complain)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);

                using (ComplainService service = new ComplainService())
                {
                    service.UpdateComplain(complain.Complain_Id, complain.Description,complain.employee,complain.employee_name,complain.department_id,complain.fecha);
                    data.result = null;
                    data.status = true;
                    data.message = "Su queja se actualió correctament";
                }
            }
            catch (Exception ex)
            {
                response.StatusCode = config.isAuthenticated ? HttpStatusCode.BadRequest : HttpStatusCode.Unauthorized;
                data.status = false;
                data.message = ex.Message;
                data.error = NewError(ex, "Error actualizando la queja");
            }
            finally
            {
                response.Content = CreateContent(data);
            }

            return response;
        }


        [HttpDelete]
        [Route("api/complain/delete/{Complain_id}")]
        public HttpResponseMessage DeleletComplain(int Complain_id)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);

                using (ComplainService service = new ComplainService())
                {
                    service.DeleteComplain(Complain_id);
                    data.result = null;
                    data.status = true;
                    data.message = "Se ha eliminado la queja";
                }
            }
            catch (Exception ex)
            {
                response.StatusCode = config.isAuthenticated ? HttpStatusCode.BadRequest : HttpStatusCode.Unauthorized;
                data.status = false;
                data.message = ex.Message;
                data.error = NewError(ex, "Eliminar queja");
            }
            finally
            {
                response.Content = CreateContent(data);
            }

            return response;
        }



        [HttpGet]
        [Route("api/Complain/AllComplains/{state}/{from}/{to}")]
        public HttpResponseMessage AllComplains(string state,string from,string to)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);

                if (from == "_ALL_")
                {
                    from = "";
                }

                if (to == "_ALL_")
                {
                    to = "";
                }


                if (state == "-1")
                {
                    state = "";
                }


                using (ComplainService service = new ComplainService())
                {
                    var complains = service.AllComplains(state,to,from);
                    data.result = new { complains, service.attendedcomplaints, service.newcomplaints, service.complaintsinprocess };
                    data.status = true;
                }
            }
            catch (Exception ex)
            {
                response.StatusCode = config.isAuthenticated ? HttpStatusCode.BadRequest : HttpStatusCode.Unauthorized;
                data.status = false;
                data.message = ex.Message;
                data.error = NewError(ex, "Lista de Quejas");
            }
            finally
            {
                response.Content = CreateContent(data);
            }

            return response;
        }


        [HttpPost]
        [Route("api/complain/UpdateComplainbyAdmin/")]
        public HttpResponseMessage UpdateComplainbyAdmin(Complain complain)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);

                using (ComplainService service = new ComplainService())
                {
                    service.UpdateComplainbyAdmin(complain.Complain_Id, complain.state, complain.Answer);
                    data.result = null;
                    data.status = true;
                    data.message = "Se actualizo la queja";
                }
            }
            catch (Exception ex)
            {
                response.StatusCode = config.isAuthenticated ? HttpStatusCode.BadRequest : HttpStatusCode.Unauthorized;
                data.status = false;
                data.message = ex.Message;
                data.error = NewError(ex, "hubo un error");
            }
            finally
            {
                response.Content = CreateContent(data);
            }

            return response;
        }

    }
}