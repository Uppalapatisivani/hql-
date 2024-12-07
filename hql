package com.klef.jfsd.exam;

import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.hibernate.cfg.Configuration;

public class ClientDemo {
    public static void main(String[] args) {
        
        SessionFactory sessionFactory = new Configuration().configure().addAnnotatedClass(Department.class).buildSessionFactory();
        Session session = sessionFactory.openSession();

        try {
 
            insertDepartment(session, "Computer Science", "Building A", "Dr. Smith");
            insertDepartment(session, "Mechanical Engineering", "Building B", "Dr. Johnson");

          
            deleteDepartment(session, 1); 
        } finally {
            session.close();
            sessionFactory.close();
        }
    }

   
    public static void insertDepartment(Session session, String name, String location, String hodName) {
        Transaction transaction = session.beginTransaction();
        Department department = new Department();
        department.setName(name);
        department.setLocation(location);
        department.setHodName(hodName);

        session.save(department);
        transaction.commit();
        System.out.println("Department inserted: " + department);
    }

    
    public static void deleteDepartment(Session session, int departmentId) {
        Transaction transaction = session.beginTransaction();
        String hql = "DELETE FROM Department WHERE id = ?1";
        int rowsAffected = session.createQuery(hql).setParameter(1, departmentId).executeUpdate();
        transaction.commit();
        System.out.println("Number of rows affected: " + rowsAffected);
    }
}
