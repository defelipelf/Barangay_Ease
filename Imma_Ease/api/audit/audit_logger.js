// /Imma_Ease/api/audit/audit_logger.js
const Audit = {
    log: function(action, module, details = {}) {
        // Get current user from localStorage
        const user = JSON.parse(localStorage.getItem('user') || '{}');
        
        // Prepare data
        const logData = {
            user_id: user.id || null,
            username: user.username || 'system',
            action: action,
            module: module,
            details: details
        };
        
        console.log('📝 Sending audit log:', logData);
        
        // Send to server
        fetch('/Imma_Ease/api/audit/log.php', {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            },
            body: JSON.stringify(logData)
        })
        .then(response => response.json())
        .then(data => {
            console.log('✅ Audit log saved:', data);
        })
        .catch(error => {
            console.error('❌ Audit log failed:', error);
        });
    }
};

// Make it available everywhere
window.Audit = Audit;