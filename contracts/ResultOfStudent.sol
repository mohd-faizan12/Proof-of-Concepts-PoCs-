// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract Result{
    address public PrincipleAdd;
    struct studentMarksStructure{
    uint[] subjectList;
    mapping(uint=>uint) subjectmarks;
    bool grade;
}
 mapping(address=>studentMarksStructure) studentResult;
 modifier mOwnerOnly{
     require(PrincipleAdd==msg.sender, "You are not authorised!");
     _;
 }
 modifier mStudentOnly(address _studentId){
      require(msg.sender==_studentId || msg.sender==PrincipleAdd , "Marks can't be visible!");
      _;
 }
 event eSubjectsmarks(uint _marks );
 event eGrade(bool grade);
 constructor(){
     PrincipleAdd=msg.sender;
 }
 function AddstudentMarks(address _studentId, uint _subjectId, uint _marks) public{
    studentResult[_studentId].subjectList.push(_subjectId);
    studentResult[_studentId].subjectmarks[_subjectId]=_marks;
    emit eSubjectsmarks(_marks);
 }
 function GetsubjectMarks(address _studentId,uint _subjectId) public view mStudentOnly(_studentId)  returns(uint){
    return studentResult[_studentId].subjectmarks[_subjectId];
 }
 function getTotalMarks(address _studentId) public view mStudentOnly(_studentId) returns(uint){
     uint totalMarks=0;
     for(uint i=0;i<studentResult[_studentId].subjectList.length;i++){
     totalMarks=studentResult[_studentId].subjectmarks[studentResult[_studentId].subjectList[i]]+totalMarks;
     }
     return totalMarks;
 }
 function addGrade(address _studentId) public mOwnerOnly returns(bool){
     uint _total=getTotalMarks( _studentId);
     if(_total>99){
     studentResult[_studentId].grade=true;
     }
     emit eGrade(studentResult[_studentId].grade);
     return studentResult[_studentId].grade;
 }
}