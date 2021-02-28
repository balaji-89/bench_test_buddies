class Solution {
  int attemptId;
  String question;
  var userAnswer;
  var correctAnswer;
  int evaluationId;
  var image;
  var video;
  String explanation;
  String commonErrorCause;
  String prevent;
  int bookmarkStatus;

  Solution(
      {this.attemptId,
        this.evaluationId,
        this.question,
        this.correctAnswer,
        this.userAnswer,
        this.image,
        this.video,
        this.explanation,
        this.commonErrorCause,
        this.prevent,
        this.bookmarkStatus});
}