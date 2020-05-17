using Business.Base;
using Business.Models;
using System;
using System.Collections.Generic;
using System.Data;
using static Business.Utilities.Functions;

namespace Business.Services
{
    public class DepartmentService : BaseService, IDisposable
    {
        public DepartmentService() : base()
        {

        }


        public void saveDepartment(Department department)
        {
            string query;

            try
            {
                connection.Open();
                connection.BeginTransaction();



                query = "CALL SaveDepartment(" + department.department_Id.ToString() + ",'" + department.name + "'" + "," + department.person_id.ToString() + ")";

                connection.Execute(query);
                connection.CommitTransaction();
            }
            catch (Exception ex)
            {
                connection.RollBackTransaction();
                throw ex;
            }
            finally
            {
                connection.Close();
            }
        }


        public List<Department> DepartmentList(string filter)
        {
            List<Department> departments = new List<Department>();
            DataSet data;
            string query;

            try
            {
                connection.Open();

                query = "CALL DepartmentList( '"+  filter + "' )";

                data = connection.SelectData(query);

                if (data == null || data.Tables.Count == 0)
                    VerifyMessage("Ocurrió un error durante la transacción por favor inténtelo de nuevo");

                foreach (DataRow row in data.Tables[0].Rows)
                {
                    departments.Add(new Department()
                    {
                        department_Id = int.Parse(row["Department_Id"].ToString()),
                        name = row["DepartmentName"].ToString(),
                        person_id = row["Person_Id"].ToString(),
                        personname = row["Name"].ToString(),
                    });
                }



                return departments;
            }
            catch (Exception ex)
            {
                throw ex;
            }
            finally
            {
                connection.Close();
            }
        }




        public void DeleteDepartment(int Department_id)
        {
            string query;

            try
            {
                connection.Open();
                connection.BeginTransaction();

                query = "CALL DeleteDepartment" + "('" + Department_id + "'" + ")";

                connection.Execute(query);
                connection.CommitTransaction();
            }
            catch (Exception ex)
            {
                connection.RollBackTransaction();
                throw ex;
            }
            finally
            {
                connection.Close();
            }
        }


        public void Dispose()
        {
            if (connection != null)
                connection.Close();

            connection = null;
        }
    }
}
