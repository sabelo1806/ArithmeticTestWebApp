<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Assessment Summary — TUT Arithmetic Assessment</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <%
        String name = (String) session.getAttribute("name");
        if (name == null) name = "Student";

        Integer countObj              = (Integer) session.getAttribute("count");
        Integer correctObj            = (Integer) session.getAttribute("countCorrectAnswers");
        Integer wrongObj              = (Integer) session.getAttribute("wrongAnswers");

        int count              = (countObj  != null) ? countObj  : 0;
        int countCorrectAnswers = (correctObj != null) ? correctObj : 0;
        int wrongAnswers       = (wrongObj   != null) ? wrongObj   : 0;

        // Recalculate to avoid integer division truncation from JSP
        double percentageMark = (count > 0) ? ((double) countCorrectAnswers / count) * 100.0 : 0.0;
        String grade;
        String gradeColor;
        if      (percentageMark >= 75) { grade = "Distinction"; gradeColor = "#2D6A4F"; }
        else if (percentageMark >= 60) { grade = "Merit";       gradeColor = "#1A5276"; }
        else if (percentageMark >= 50) { grade = "Pass";        gradeColor = "#C9A227"; }
        else                           { grade = "Below Pass";  gradeColor = "#9B2335"; }
    %>

    <header class="site-header">
        <div class="crest">Σ</div>
        <span class="institution">Tshwane University of Technology &nbsp;·&nbsp; Department of Mathematics</span>
    </header>

    <main>
        <div class="exam-card">
            <div class="card-header">
                <div class="label">Assessment Complete</div>
                <h2>Results Summary</h2>

                <div class="progress-track">
                    <% for (int i = 1; i <= 5; i++) { %>
                        <div class="progress-dot answered"><%= i %></div>
                    <% } %>
                    <span class="progress-label">All complete</span>
                </div>
            </div>
            <div class="card-body">
                <div class="score-display">
                    <div class="score-number">
                        <%= String.format("%.0f", percentageMark) %><span class="percent">%</span>
                    </div>
                    <div class="score-caption">Final Score &nbsp;·&nbsp;
                        <span style="color:<%= gradeColor %>; font-weight:600;"><%= grade %></span>
                    </div>
                </div>

                <table class="results-table">
                    <tr>
                        <td>Student</td>
                        <td><%= name %></td>
                    </tr>
                    <tr>
                        <td>Total Questions</td>
                        <td><%= count %></td>
                    </tr>
                    <tr>
                        <td>Correct Answers</td>
                        <td style="color:#2D6A4F;"><%= countCorrectAnswers %></td>
                    </tr>
                    <tr>
                        <td>Incorrect Answers</td>
                        <td style="color:#9B2335;"><%= wrongAnswers %></td>
                    </tr>
                    <tr>
                        <td>Percentage Mark</td>
                        <td><%= String.format("%.1f", percentageMark) %>%</td>
                    </tr>
                </table>

                <div class="divider"></div>

                <div style="display:flex; gap:12px; flex-wrap:wrap;">
                    <a href="EndSessionServlet.do" class="btn btn-primary">End Session</a>
                    <a href="start.jsp" class="btn btn-link">Retake Test</a>
                </div>
            </div>
            <div class="card-footer">
                <span>Session: <%= name %></span>
                <span>Results are session-only and will not be saved</span>
            </div>
        </div>
    </main>
</body>
</html>
