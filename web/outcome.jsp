<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <%
        Integer countObj = (Integer) session.getAttribute("count");
        int count = (countObj != null) ? countObj : 1;
    %>
    <title>Question <%= count %> Result — TUT Arithmetic Assessment</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <%
        Integer userAnswerObj    = (Integer) session.getAttribute("userAnswer");
        Integer correctAnswerObj = (Integer) session.getAttribute("correctAnswer");
        String outcome      = (String)  session.getAttribute("outcome");
        String questionText = (String)  session.getAttribute("questionText");
        String name         = (String)  session.getAttribute("name");

        int userAnswer    = (userAnswerObj != null)    ? userAnswerObj    : 0;
        int correctAnswer = (correctAnswerObj != null) ? correctAnswerObj : 0;
        if (outcome == null)      outcome      = "";
        if (questionText == null) questionText = "";
        if (name == null)         name         = "Student";

        boolean isCorrect = "Correct".equals(outcome);
    %>

    <header class="site-header">
        <div class="crest">Σ</div>
        <span class="institution">Tshwane University of Technology &nbsp;·&nbsp; Department of Mathematics</span>
    </header>

    <main>
        <div class="exam-card">
            <div class="card-header">
                <div class="label">Result &nbsp;·&nbsp; Question <%= count %> of 5</div>
                <h2>Question <%= count %> Outcome</h2>

                <div class="progress-track">
                    <% for (int i = 1; i <= 5; i++) { %>
                        <div class="progress-dot <%= (i <= count) ? "answered" : "" %>">
                            <%= i %>
                        </div>
                    <% } %>
                </div>
            </div>
            <div class="card-body">
                <div class="question-box">
                    <div class="q-label">Question Asked</div>
                    <div class="q-text"><%= questionText %></div>
                </div>

                <table class="results-table">
                    <tr>
                        <td>Your Answer</td>
                        <td><%= userAnswer %></td>
                    </tr>
                    <tr>
                        <td>Correct Answer</td>
                        <td><%= correctAnswer %></td>
                    </tr>
                    <tr>
                        <td>Result</td>
                        <td>
                            <span class="outcome-badge <%= isCorrect ? "correct" : "incorrect" %>">
                                <%= isCorrect ? "✓ Correct" : "✗ Incorrect" %>
                            </span>
                        </td>
                    </tr>
                </table>

                <%
                    Integer correctCountObj = (Integer) session.getAttribute("countCorrectAnswers");
                    int correctSoFar = (correctCountObj != null) ? correctCountObj : 0;
                %>
                <p class="intro-text" style="font-size:0.88rem;">
                    Score so far: <strong><%= correctSoFar %> / <%= count %></strong> correct
                </p>

                <% if (count < 5) { %>
                    <form action="TakeTestServlet.do" method="POST">
                        <button type="submit" class="btn btn-primary">Next Question →</button>
                    </form>
                <% } else { %>
                    <a href="summary.jsp" class="btn btn-accent">View Final Results →</a>
                <% } %>
            </div>
            <div class="card-footer">
                <span>Session: <%= name %></span>
                <span><%= count %> / 5 completed</span>
            </div>
        </div>
    </main>
</body>
</html>
