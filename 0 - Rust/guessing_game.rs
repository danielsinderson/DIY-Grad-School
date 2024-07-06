use rand::Rng;
use std::cmp::Ordering;
use std::io; //import standard input / output

fn main() {
    println!("Guess the number! This is not really a game, just practice.");

    let secret_number = rand::thread_rng().gen_range(1..=100);
    //println!("The secret number is {secret_number}");

    loop {
        println!("Now please input your guess.");
        let mut guess = String::new(); // create a mutable string variable

        io::stdin()
            .read_line(&mut guess) // give the readline function a reference to our mutable string
            .expect("Failed to read line");

        let guess: u32 = match guess.trim().parse() {
            Ok(num) => num,
            Err(_) => continue,
        };

        println!("You guessed: {guess}");

        match guess.cmp(&secret_number) {
            Ordering::Less => println!("Too small!"),
            Ordering::Greater => println!("Too big!"),
            Ordering::Equal => {
                println!("You did it! Oh my god!");
                break;
            }
        }
    }
}
