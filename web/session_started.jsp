<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Choose Operator — TUT Arithmetic Assessment</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <%
        String name = (String) session.getAttribute("name");
        String computerName = pageContext.getServletContext().getInitParameter("computer_name");
        // Sanitize output to prevent XSS
        if (name == null) name = "Student";
        if (computerName == null) computerName = "the system";
    %>

    <header class="site-header">
        <div class="crest">Σ</div>
        <span class="institution">Tshwane University of Technology &nbsp;·&nbsp; Department of Mathematics</span>
    </header>

    <main>
        <div class="exam-card">
            <div class="card-header">
                <div class="label">Step 2 of 3 &nbsp;·&nbsp; Configuration</div>
                <h2>Select Your Operator</h2>
            </div>
            <div class="card-body">
                <p class="greeting-name">Welcome, <%= name %>.</p>
                <p class="intro-text">
                    I am <strong><%= computerName %></strong>, your assessment facilitator.
                    You will answer <strong>five questions</strong> based on the arithmetic
                    operator you select below. Choose carefully — the same operator
                    applies to all five questions.
                </p>

                <form action="StoreOperatorServlet.do" method="POST">
                    <div class="field-group">
                        <label class="field-label" for="operator">Arithmetic Operator</label>
                        <div class="select-wrapper">
                            <select name="operator" id="operator">
                                <option value="+">( + ) Addition</option>
                                <option value="-">( − ) Subtraction</option>
                                <option value="*">( × ) Multiplication</option>
                                <option value="/">( ÷ ) Division</option>
                            </select>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-accent">Start Test →</button>
                </form>
            </div>
            <div class="card-footer">
                <span>Session: <%= name %></span>
                <span>5 Questions Remaining</span>
            </div>
        </div>
    </main>
</body>
</html>
