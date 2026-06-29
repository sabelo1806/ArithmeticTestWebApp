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
    <title>Question <%= count %> — TUT Arithmetic Assessment</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <%
        String questionText = (String) session.getAttribute("questionText");
        if (questionText == null) questionText = "";
        String name = (String) session.getAttribute("name");
        if (name == null) name = "Student";
    %>

    <header class="site-header">
        <div class="crest">Σ</div>
        <span class="institution">Tshwane University of Technology &nbsp;·&nbsp; Department of Mathematics</span>
    </header>

    <main>
        <div class="exam-card">
            <div class="card-header">
                <div class="label">Question <%= count %> of 5</div>
                <h2>Answer the Question</h2>

                <div class="progress-track">
                    <% for (int i = 1; i <= 5; i++) { %>
                        <div class="progress-dot <%= (i < count) ? "answered" : (i == count) ? "current" : "" %>">
                            <%= i %>
                        </div>
                    <% } %>
                    <span class="progress-label"><%= (5 - count) %> remaining</span>
                </div>
            </div>
            <div class="card-body">
                <div class="question-box">
                    <div class="q-label">Question <%= count %></div>
                    <div class="q-text"><%= questionText %> = ?</div>
                </div>

                <form action="AnswerTestServlet.do" method="POST">
                    <div class="field-group">
                        <label class="field-label" for="user_answer">Your Answer</label>
                        <input
                            type="number"
                            id="user_answer"
                            name="user_answer"
                            placeholder="Enter a whole number"
                            required
                            autocomplete="off"
                            autofocus
                        />
                    </div>
                    <button type="submit" class="btn btn-primary">Submit Answer →</button>
                </form>
            </div>
            <div class="card-footer">
                <span>Session: <%= name %></span>
                <span>Question <%= count %> / 5</span>
            </div>
        </div>
    </main>
</body>
</html>
