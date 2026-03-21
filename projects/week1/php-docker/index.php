<?php
$time = date('Y-m-d H:i:s');
$php_version = phpversion();
$hostname = gethostname();
?>
<!DOCTYPE html>
<html>
<head>
    <title>My Docker PHP App</title>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css">
</head>
<body class="bg-dark text-white">
    <div class="container mt-5">
        <div class="card bg-secondary">
            <div class="card-body text-center">
                <h1 class="card-title">🐳 Running in Docker!</h1>
                <hr>
                <p class="lead">Built by <strong>Shreyansh Gupta</strong></p>
                <div class="row mt-4">
                    <div class="col-md-4">
                        <div class="card bg-success">
                            <div class="card-body">
                                <h5>⏰ Server Time</h5>
                                <p><?php echo $time; ?></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-primary">
                            <div class="card-body">
                                <h5>🐘 PHP Version</h5>
                                <p><?php echo $php_version; ?></p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card bg-warning text-dark">
                            <div class="card-body">
                                <h5>🖥️ Container Host</h5>
                                <p><?php echo $hostname; ?></p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
<h2 style='color:red;text-align:center'>Volume is working! 🎉</h2>
