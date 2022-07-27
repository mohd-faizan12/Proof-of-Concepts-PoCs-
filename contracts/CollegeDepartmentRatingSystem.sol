// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.8.0;
contract Project{
    address[] public studentList;
    struct collegeRatingStructure{
        string[] DepartmentNameList;
        mapping(string=>uint) Rating;
    }
      address admin;
      constructor(){
          admin=msg.sender;
      }
      event eEvent1(uint rating);
      modifier mOwnerOnly{
          require(msg.sender==admin,"You are not authorised");
          _;
      }
      modifier mStudentOnly(address _studentId){
         require(msg.sender==_studentId,"You are not permitted to review");
         _;
      }
    mapping(string=>collegeRatingStructure) college;
    function addStudent(address _studentId ) public mOwnerOnly{
        studentList.push(_studentId);
    }
    function setValues(string memory _key,address _studentId, string memory _departmentName, uint _ratingScore) public mStudentOnly(_studentId){
         college[_key].DepartmentNameList.push(_departmentName);
         college[_key].Rating[_departmentName]=_ratingScore; //rating out of 10
    }
function getRating(string memory _key,string memory _departmentName) public  returns(uint){
    emit eEvent1(college[_key].Rating[_departmentName]);
    return college[_key].Rating[_departmentName];
} 
}