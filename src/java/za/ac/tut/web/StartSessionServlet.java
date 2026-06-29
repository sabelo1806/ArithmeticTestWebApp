package za.ac.tut.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * StartSessionServlet — registers a new student session.
 *
 * Accepts the student's name via POST, initialises all session counters,
 * and forwards to the operator-selection page.
 */
public class StartSessionServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String name = request.getParameter("name");

        // Guard against blank or missing name
        if (name == null || name.trim().isEmpty()) {
            response.sendRedirect("start.jsp");
            return;
        }

        // Invalidate any existing session before starting a fresh one
        HttpSession old = request.getSession(false);
        if (old != null) {
            old.invalidate();
        }

        HttpSession session = request.getSession(true);
        session.setAttribute("name",                name.trim());
        session.setAttribute("count",               0);
        session.setAttribute("countCorrectAnswers", 0);
        session.setAttribute("wrongAnswers",        0);
        session.setAttribute("percentageMark",      0.0);

        RequestDispatcher disp = request.getRequestDispatcher("session_started.jsp");
        disp.forward(request, response);
    }
}
