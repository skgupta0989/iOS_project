
import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.util.ArrayList;


public class UserList {

	
	public static void main(String[] args) throws Exception
	{
		String str1, str2 = "username";
		int index;
		int initialCapacity = 10;
		BufferedReader dataIn = new BufferedReader(new InputStreamReader(System.in));
		ArrayList<String> users = new ArrayList<String>();

		System.out.print("Enter a user name: ");
		str1 = dataIn.readLine();

		while(str1.length() > 0)
		{
			if(str1.equals(str2))
					System.out.println("That user name is NOT allowed!");
			else
				{
					if(users.size() == initialCapacity)
					{
						System.out.println("List is full!");
						System.out.println("Last entry is "+users.get(initialCapacity));
					}
					else
						if(!users.contains(str1))
						{
							users.add(str1);
							System.out.println("User \""+str1+"\" added to user list.");
						}
						else
							System.out.println("User \""+str1+"\" already in user list.");
				}
			System.out.print("\nEnter a user name: ");
			str1 = dataIn.readLine();
		}
		
		System.out.println("Program complete.");
	}
}
