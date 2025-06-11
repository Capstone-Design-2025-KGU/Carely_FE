class OtherMemory {
  final int memoryId;
  final int otherMemberId;
  final String memberType;
  final String oppoName;
  final String oppoMemo;

  OtherMemory({
    required this.memoryId,
    required this.otherMemberId,
    required this.memberType,
    required this.oppoName,
    required this.oppoMemo,
  });

  factory OtherMemory.fromJson(Map<String, dynamic> json) {
    return OtherMemory(
      memoryId: json['memoryId'],
      otherMemberId: json['otherMemberId'],
      memberType: json['memberType'],
      oppoName: json['oppoName'],
      oppoMemo: json['oppoMemo'],
    );
  }
}
