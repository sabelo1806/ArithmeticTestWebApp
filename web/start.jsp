<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Registration — TUT Arithmetic Assessment</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>
    <header class="site-header">
        <div class="crest">Σ</div>
        <span class="institution">Tshwane University of Technology &nbsp;·&nbsp; Department of Mathematics</span>
    </header>

    <main>
        <div class="exam-card">
            <div class="card-header">
                <div class="label">Step 1 of 3 &nbsp;·&nbsp; Registration</div>
                <h2>Student Details</h2>
            </div>
            <div class="card-body">
                <p class="intro-text">
                    Please enter your full name to register your assessment session.
                    This name will appear on your results summary.
                </p>

                <form action="StartSessionServlet.do" method="POST">
                    <div class="field-group">
                        <label class="field-label" for="name">Full Name</label>
                        <input
                            type="text"
                            id="name"
                            name="name"
                            placeholder="e.g. Thabo Nkosi"
                            required
                            autocomplete="name"
                        />
                    </div>
                    <button type="submit" class="btn btn-primary">Register &amp; Continue →</button>
                </form>
            </div>
            <div class="card-footer">
                <a href="index.html" style="color:inherit;text-decoration:none;">← Back to Welcome</a>
                <span>No account required</span>
            </div>
        </div>
    </main>
</body>
</html>
