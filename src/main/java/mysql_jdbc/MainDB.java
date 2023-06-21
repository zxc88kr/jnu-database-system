package mysql_jdbc;

import java.util.Scanner;

public class MainDB {
	public static void main(String[] args) {
		InsertDB insert = new InsertDB();
		UpdateDB update = new UpdateDB();
		Scanner scan = new Scanner(System.in);
		while (true) {
			System.out.println("1. 추가	2. 수정	3. 종료");
			int num = scan.nextInt();
			if (num == 1) {
				System.out.println("추가");
				System.out.print("id: ");
				String id = scan.next();
				System.out.print("name: ");
				String name = scan.next();
				System.out.print("age: ");
				int age = scan.nextInt();
				System.out.print("grade: ");
				double grade = scan.nextDouble();
				insert.insert(id, name, age, grade);
			} else if (num == 2) {
				System.out.print("id: ");
				String id = scan.next();
				System.out.print("name: ");
				String name = scan.next();
				System.out.print("age: ");
				int age = scan.nextInt();
				System.out.print("grade: ");
				double grade = scan.nextDouble();
				update.update(id, name, age, grade);
			} else {
				System.out.println("종료");
				break;
			}
		}
		scan.close();
	}
}