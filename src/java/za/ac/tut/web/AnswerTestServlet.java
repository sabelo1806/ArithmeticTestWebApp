package za.ac.tut.web;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;

/**
 * AnswerTestServlet — validates the student's submitted answer, updates
 * session counters, and forwards to the outcome page.
 */
public class AnswerTestServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession();

        // Parse answer safely
        int userAnswer;
        try {
            userAnswer = Integer.parseInt(request.getParameter("user_answer").trim());
        } catch (NumberFormatException | NullPointerException e) {
            // Bounce back to the question page if input is invalid
            RequestDispatcher disp = request.getRequestDispatcher("answer_first_question.jsp");
            disp.forward(request, response);
            return;
        }

        int count               = (int)    session.getAttribute("count");
        int countCorrectAnswers = (int)    session.getAttribute("countCorrectAnswers");
        int wrongAnswers        = (int)    session.getAttribute("wrongAnswers");
        int correctAnswer       = (int)    session.getAttribute("correctAnswer");

        String outcome;
        if (userAnswer == correctAnswer) {
            outcome = "Correct";
            countCorrectAnswers++;
        } else {
            outcome = "Incorrect";
            wrongAnswers++;
        }

        double percentageMark = (count > 0) ? ((double) countCorrectAnswers / count) * 100.0 : 0.0;

        session.setAttribute("userAnswer",           userAnswer);
        session.setAttribute("outcome",              outcome);
        session.setAttribute("countCorrectAnswers",  countCorrectAnswers);
        session.setAttribute("wrongAnswers",         wrongAnswers);
        session.setAttribute("percentageMark",       percentageMark);

        RequestDispatcher disp = request.getRequestDispatcher("outcome.jsp");
        disp.forward(request, response);
    }
}
