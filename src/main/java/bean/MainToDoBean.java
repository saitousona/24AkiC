package bean;

import java.sql.Date;

public class MainToDoBean {
    private int ticketId; // チケットID
    private String title; // チケットのタイトル
    private Date deadline; // 期限日
    private String assignedPerson; // 担当者
    private String importance; // 重要度
    private int progress; // 進行度
    private String category; // カテゴリー
    private String userEmail; // チケットの所有者のメールアドレス
    
    private boolean shared; // 共有状態を表すプロパティ


    
    public MainToDoBean() {
        // デフォルトコンストラクタ
    }
    public MainToDoBean(String title, Date deadline, String assignedPerson, String importance, int progress, String category, String userEmail) {
    	this.title = title;
    	this.deadline = deadline;
    	this.assignedPerson = assignedPerson;
    	this.importance = importance;
    	this.progress = progress;
    	this.category = category;
    	this.userEmail = userEmail;
    }

    // コンストラクタ
    public MainToDoBean(int ticketId, String title, Date deadline, String assignedPerson, String importance, int progress, String category, String userEmail) {
        this.ticketId = ticketId;
        this.title = title;
        this.deadline = deadline;
        this.assignedPerson = assignedPerson;
        this.importance = importance;
        this.progress = progress;
        this.category = category;
        this.userEmail = userEmail;
    }

    // ゲッターとセッター
    public int getTicketId() { return ticketId; }
    public void setTicketId(int ticketId) { this.ticketId = ticketId; }

    public String getTitle() { return title; }
    public void setTitle(String title) { this.title = title; }

    public Date getDeadline() { return deadline; }
    public void setDeadline(Date deadline) { this.deadline = deadline; }

    public String getAssignedPerson() { return assignedPerson; }
    public void setAssignedPerson(String assignedPerson) { this.assignedPerson = assignedPerson; }

    public String getImportance() { return importance; }
    public void setImportance(String importance) { this.importance = importance; }

    public int getProgress() { return progress; }
    public void setProgress(int progress) { this.progress = progress; }

    public String getCategory() { return category; }
    public void setCategory(String category) { this.category = category; }

    public String getUserEmail() { return userEmail; }
    public void setUserEmail(String userEmail) { this.userEmail = userEmail; }
    
    // ゲッターとセッター
    public boolean isShared() {
        return shared;
    }

    public void setShared(boolean shared) {
        this.shared = shared;
    }
}
