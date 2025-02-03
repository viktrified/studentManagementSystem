// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

contract StudentManagement {
    address owner;

    // constructor() {
    //     owner = msg.sender;
    // }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the admin");
        _;
    }

    modifier doesNotExit(uint256 _studentId) {
        require(
            students[_studentId].isRegistered,
            "This student does not exist"
        );
        _;
    }

    mapping(string => uint) private nameToId;
    mapping(uint256 => Student) students;

    enum Gender {
        Male,
        Female
    }
    enum Class {
        NurseryOne,
        NurseryTwo,
        NurseryThree,
        PrimaryTwo,
        PrimaryOne,
        PrimaryThree,
        PrimaryFour,
        PrimaryFive,
        JssOne,
        JssTwo,
        JssThree,
        SsOne,
        SsTwo,
        SsThree
    }

    struct Student {
        string name;
        uint256 age;
        Class class;
        Gender gender;
        uint256 registrationTime;
        bool isRegistered;
    }

    event CreatedStudent(
        string indexed name,
        Class indexed class,
        uint256 indexed age
    );

    uint256 studentId = 0;

    function registerStudent(
        string memory _name,
        uint256 _age,
        Class _class,
        Gender _gender
    ) external onlyOwner{
        Student memory student = Student({
            name: _name,
            age: _age,
            class: _class,
            gender: _gender,
            registrationTime: block.timestamp,
            isRegistered: true
        });

        studentId++;
        students[studentId] = student;

        emit CreatedStudent(_name, _class, _age);
    }

    function getStudent(uint256 _studentId)
        public
        view
        doesNotExit(_studentId)
        returns (Student memory student_)
    {
        student_ = students[_studentId];
    }

    function getAllStudent() public view returns (Student[] memory students_) {
        students_ = new Student[](studentId);

        for (uint256 i = 1; i <= studentId; i++) {
            students_[i - 1] = students[i];
        }

        students_;
    }

    function getStudentAge(uint256 _studentId)
        public
        view
        doesNotExit(_studentId)
        returns (uint256)
    {
        Student memory student = students[_studentId];
        uint256 yearsPassed = (block.timestamp - student.registrationTime) /
            365 days;
        return student.age + uint256(yearsPassed);
    }

    function getRegistrationTime(uint256 _studentId)
        public
        view
        doesNotExit(_studentId)
        returns (uint256)
    {
        Student memory student = students[_studentId];
        uint256 registrationTime = student.registrationTime;
        return registrationTime;
    }

    function getClass(uint256 _studentId)
        public
        view
        doesNotExit(_studentId)
        returns (Class)
    {
        Student memory student = students[_studentId];
        Class class = student.class;
        return class;
    }
}
