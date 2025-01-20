
const db = firebase.database();

const allMessagesDiv = document.getElementById('allMessages');

const messagesRef = db.ref('messages');

messagesRef.on('child_added', (snapshot) => {
    const nameBasedId = snapshot.key;
    const userMessages = snapshot.val();

    for (const messageKey in userMessages) {
        const message = userMessages[messageKey];
        displayAdminMessage(message, nameBasedId, messageKey);
    }
});

function displayAdminMessage(message, nameBasedId, messageKey) {
    const messageDiv = document.createElement('div');
    messageDiv.classList.add('message', 'admin-view');
    messageDiv.innerHTML = `
        <p><strong>${message.name}</strong> (${message.subject}) - ${new Date(message.timestamp).toLocaleString()}</p>
        <p>${message.message}</p>
        <textarea id="reply-${nameBasedId}-${messageKey}" placeholder="Reply to this message"></textarea>
        <button onclick="sendReply('${nameBasedId}', '${messageKey}')">Send Reply</button>
        <div id="replies-${nameBasedId}-${messageKey}"></div>
    `;
    allMessagesDiv.appendChild(messageDiv);
    loadReplies(nameBasedId, messageKey);
}

function sendReply(nameBasedId, messageKey) {
    const replyText = document.getElementById(`reply-${nameBasedId}-${messageKey}`).value;
    if (replyText.trim() !== "") {
        const repliesRef = db.ref(`messages/${nameBasedId}/${messageKey}/replies`);
        repliesRef.push({
            text: replyText,
            timestamp: new Date().toISOString(),
            sender: 'admin'
        });
        document.getElementById(`reply-${nameBasedId}-${messageKey}`).value = '';
    }
}

function loadReplies(nameBasedId, messageKey) {
    const repliesRef = db.ref(`messages/${nameBasedId}/${messageKey}/replies`);
    repliesRef.on('child_added', (snapshot) => {
        const reply = snapshot.val();
        displayReply(reply, nameBasedId, messageKey);
    });
}

function displayReply(reply, nameBasedId, messageKey) {
    const repliesDiv = document.getElementById(`replies-${nameBasedId}-${messageKey}`);
    const replyDiv = document.createElement('div');
    replyDiv.classList.add('reply', reply.sender);
    replyDiv.innerHTML = `
        <p><strong>${reply.sender}:</strong> ${reply.text} - ${new Date(reply.timestamp).toLocaleString()}</p>
    `;
    repliesDiv.appendChild(replyDiv);
}