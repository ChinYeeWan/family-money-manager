import '../models/category.dart';

class FixCategoryIconService {
  //* FIRST : EXPENSE LIST
  final List<Category> expenseList = [
    Category(
        id: "10000",
        name: "Food",
        icon: "0xf2e7", //FontAwesomeIcons.utensils.codePoint
        color: 4294967040),
    Category(
        id: "10001",
        name: "Bills",
        icon: "0xf0d6", //FontAwesomeIcons.moneyBill.codePoint
        color: 4283215696),
    Category(
        id: "10002",
        name: "Transportation",
        icon: "0xf1b9", //FontAwesomeIcons.car.codePoint
        color: 4292886779),
    Category(
        id: "10003",
        name: "Games",
        icon: "0xf11b", //FontAwesomeIcons.gamepad.codePoint
        color: 4279828479),
    Category(
        id: "10004",
        name: "Shopping",
        icon: "0xf290", //FontAwesomeIcons.bagShopping.codePoint
        color: 4294924066),
    Category(
        id: "10005",
        name: "Telephone",
        icon: "0xf095", //FontAwesomeIcons.phone.codePoint
        color: 4283657726),
    Category(
        id: "10006",
        name: "Sport",
        icon: "0xf44e", //FontAwesomeIcons.football.codePoint
        color: 4288585374),
    Category(
        id: "10007",
        name: "Beauty",
        icon: "0xf580", //FontAwesomeIcons.faceGrin.codePoint,
        color: 4294918273),
    Category(
        id: "10007",
        name: "Gift",
        icon: "0xf06b", //FontAwesomeIcons.gift.codePoint,
        color: 4293467747),
  ];
  //* SECOND : INCOME LIST
  final List<Category> incomeList = [
    Category(
        id: "10008",
        name: "Salary",
        icon: "0xf555", //FontAwesomeIcons.wallet.codePoint
        color: 4283215696),
    Category(
        id: "10009",
        name: "Saving",
        icon: "0xf4d3", //FontAwesomeIcons.piggyBank.codePoint
        color: 4294967040),
    Category(
        id: "10010",
        name: "Investment",
        icon: "0xf201", //FontAwesomeIcons.chartLine.codePoint
        color: 4294198070),
    Category(
        id: "10011",
        name: "Rental",
        icon: "0xe1b0", //FontAwesomeIcons.houseUser.codePoint
        color: 4294961979),
    Category(
        id: "10012",
        name: "Awards",
        icon: "0xf53c", //FontAwesomeIcons.moneyCheck.codePoint
        color: 4294951175),
    Category(
        id: "10013",
        name: "Grants",
        icon: "0xf79c", //FontAwesomeIcons.gifts.codePoint
        color: 4292886779),
  ];
}
