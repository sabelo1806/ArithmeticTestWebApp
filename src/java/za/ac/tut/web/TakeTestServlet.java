package za.ac.tut.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.util.Random;

/**
 * TakeTestServlet — generates the next arithmetic question and stores it in
 * the session, then forwards to the answer page.
 *
 * <p>For division, the dividend is chosen as a multiple of the divisor so that
 * the result is always a whole number and the question is unambiguous.</p>
 */
public class TakeTestServlet extends HttpServlet {

    private static final int MAX_OPERAND = 12; // keeps numbers school-appropriate

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();
        String operator = (String) session.getAttribute("operator");

        if (operator == null) {
            response.sendRedirect("session_started.jsp");
            return;
        }

        int count = (int) session.getAttribute("count");

        // Guard: test is already complete
        if (count >= 5) {
            response.sendRedirect("summary.jsp");
            return;
        }

        Random random = new Random();
        int firstNum, secNum, correctAnswer;
        String questionText;

        switch (operator) {
            case "+" -> {
                firstNum      = random.nextInt(MAX_OPERAND) + 1;
                secNum        = random.nextInt(MAX_OPERAND) + 1;
                correctAnswer = firstNum + secNum;
                questionText  = "What is " + firstNum + " + " + secNum;
            }
            case "-" -> {
                firstNum      = random.nextInt(MAX_OPERAND) + 1;
                secNum        = random.nextInt(MAX_OPERAND) + 1;
                correctAnswer = firstNum - secNum;
                questionText  = "What is " + firstNum + " − " + secNum;
            }
            case "*" -> {
                firstNum      = random.nextInt(MAX_OPERAND) + 1;
                secNum        = random.nextInt(MAX_OPERAND) + 1;
                correctAnswer = firstNum * secNum;
                questionText  = "What is " + firstNum + " × " + secNum;
            }
            case "/" -> {
                // Ensure exact integer division: pick secNum first, then a multiple
                secNum        = random.nextInt(MAX_OPERAND) + 1;
                correctAnswer = random.nextInt(MAX_OPERAND) + 1;
                firstNum      = secNum * correctAnswer;
                questionText  = "What is " + firstNum + " ÷ " + secNum;
            }
            default -> {
                response.sendRedirect("session_started.jsp");
                return;
            }
        }

        count++;

        session.setAttribute("firstNum",      firstNum);
        session.setAttribute("secNum",        secNum);
        session.setAttribute("questionText",  questionText);
        session.setAttribute("correctAnswer", correctAnswer);
        session.setAttribute("count",         count);

        RequestDispatcher disp = request.getRequestDispatcher("answer_first_question.jsp");
        disp.forward(request, response);
    }
}
