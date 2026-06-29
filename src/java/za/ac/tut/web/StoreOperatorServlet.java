package za.ac.tut.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Set;

/**
 * StoreOperatorServlet — validates and stores the chosen arithmetic operator,
 * then chains into TakeTestServlet to generate the first question.
 */
public class StoreOperatorServlet extends HttpServlet {

    private static final Set<String> VALID_OPERATORS = Set.of("+", "-", "*", "/");

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String operator = request.getParameter("operator");

        // Reject any value not in the allowed set
        if (!VALID_OPERATORS.contains(operator)) {
            response.sendRedirect("session_started.jsp");
            return;
        }

        HttpSession session = request.getSession();
        session.setAttribute("operator", operator);

        // Chain directly into TakeTestServlet so the first question is generated
        RequestDispatcher disp = request.getRequestDispatcher("TakeTestServlet.do");
        disp.forward(request, response);
    }
}
