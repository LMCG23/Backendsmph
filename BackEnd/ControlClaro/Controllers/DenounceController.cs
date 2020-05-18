using Business.Models;
using Business.Services;
using System;
using System.Net;
using System.Net.Http;
using System.Web.Http;
using static Business.Utilities.Functions;
namespace ControlClaro.Controllers
{
    public class DenounceController : ApiController
    {
      
        [HttpGet]
        [Route("api/Denuncias/tikets/{Department_id}/{Ticketcol}")]
        public HttpResponseMessage obtainTicket(int Department_id,string Ticketcol)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);



                using (DenounceService service = new DenounceService())
                {
                    var tike = service.obtainticket(Department_id,Ticketcol);
                    data.result = new { tike };
                    data.status = true;
                }
            }
            catch (Exception ex)
            {
                response.StatusCode = config.isAuthenticated ? HttpStatusCode.BadRequest : HttpStatusCode.Unauthorized;
                data.status = false;
                data.message = ex.Message;
                data.error = NewError(ex, "tikete");
            }
            finally
            {
                response.Content = CreateContent(data);
            }

            return response;
        }

        [HttpPost]
        [Route("api/Denuncias/NuevaDenuncia/{Denuncia}")]
        public HttpResponseMessage SaveDenounce(Denounce Denuncia)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);

                using (DenounceService service = new DenounceService())
                {
                    service.saveDenounce(Denuncia.Denounces_id,Denuncia.Description, Denuncia.state, Denuncia.person_Id, Denuncia.User_id, Denuncia.Department_Id, Denuncia.Photo, Denuncia.Latitud.ToString(), Denuncia.Longitud.ToString());
                    data.result = null;
                    data.status = true;
                    data.message = Denuncia.Denounces_id == 0 ? "Se creó la Denuncia": "Se actualizó la Denuncia";
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



        [HttpDelete]
        [Route("api/denounce/delete/{denounce_id}")]
        public HttpResponseMessage DeleletComplain(int denounce_id)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);

                using (DenounceService service = new DenounceService())
                {
                    service.DeleteDenounce(denounce_id);
                    data.result = null;
                    data.status = true;
                    data.message = "Se ha eliminado la denuncia";
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
        [Route("api/Denuncias/List/{Id_User}/{desde}/{hasta}/{state}/{deparment}")]
        public HttpResponseMessage ListDenouncesbyId(int Id_User,string desde,string hasta,string state,string deparment)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);
                if (desde == "_ALL_") desde = "";
                if (hasta == "_ALL_") hasta = "";
                if (state == "-1") state = "";
                if (deparment == "-1") deparment = "";
                using (DenounceService service = new DenounceService())
                {
                    
                    data.result = service.ListDenouncesbyId(Id_User.ToString(), desde,hasta,state,deparment);
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





        [HttpGet]
        [Route("api/Denuncias/ListDenouncesbyDepartment/{Department_id}/{state}/{from}/{to}")]
        public HttpResponseMessage ListDenouncesbyDepartment(int Department_id,string state,string from,string to)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);

                if (from == "_ALL_") {
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

                using (DenounceService service = new DenounceService())
                {
                    var Denounces = service.ListDenouncesbyDepartment(Department_id, state, from, to);
                    data.result = new { Denounces, service.newdenounces, service.denouncesinprocess, service.attendeddenounces };
                    data.status = true;
                }
            }
            catch (Exception ex)
            {
                response.StatusCode = config.isAuthenticated ? HttpStatusCode.BadRequest : HttpStatusCode.Unauthorized;
                data.status = false;
                data.message = ex.Message;
                data.error = NewError(ex, "Lista de Denuncias por Departamento");
            }
            finally
            {
                response.Content = CreateContent(data);
            }

            return response;
        }

        [HttpPost]
        [Route("api/Denounce/UpdateDenouncebyAdmin/{act}")]
        public HttpResponseMessage UpdateDenouncebyAdmin([FromBody] Denounce Denuncia, string act)
        {
            HttpResponseMessage response = new HttpResponseMessage(HttpStatusCode.OK);
            ResponseConfig config = VerifyAuthorization(Request.Headers);
            RestResponse data = new RestResponse();

            try
            {
                VerifyMessage(config.errorMessage);

                using (DenounceService service = new DenounceService())
                {
                    service.UpdateDenouncebyAdmin(Denuncia.Denounces_id, Denuncia.state, Denuncia.Department_Id, Denuncia.Answer,act);
                    data.result = null;
                    data.status = true;
                    data.message = act == "R" ? "Se direccionó la denuncia Correctamente" : "Se le ha dado una respuesta a la denuncia correctamente";
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