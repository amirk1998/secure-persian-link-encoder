"""
Secure Persian Link Encoder - Desktop Version
Main Application with CustomTkinter UI
Author: Amir Hossein Kaveh
License: MIT
"""

import customtkinter as ctk
from tkinter import messagebox
import pyperclip
import webbrowser
from crypto_core import CryptoCore

# Set appearance mode and color theme
ctk.set_appearance_mode("dark")  # Modes: "System", "Dark", "Light"
ctk.set_default_color_theme("blue")  # Themes: "blue", "green", "dark-blue"


class SecurePersianLinkApp(ctk.CTk):
    def __init__(self):
        super().__init__()

        # Initialize crypto core
        self.crypto = CryptoCore()

        # Configure window
        self.title("🔐 Secure Persian Link Encoder")
        self.geometry("700x750")
        self.resizable(True, True)

        # Set minimum size
        self.minsize(600, 650)

        # Center window on screen
        self.center_window()

        # Create UI
        self.create_widgets()

    def center_window(self):
        """Center the window on screen"""
        self.update_idletasks()
        width = self.winfo_width()
        height = self.winfo_height()
        x = (self.winfo_screenwidth() // 2) - (width // 2)
        y = (self.winfo_screenheight() // 2) - (height // 2)
        self.geometry(f"{width}x{height}+{x}+{y}")

    def create_widgets(self):
        """Create all UI widgets"""

        # Main container with padding
        main_frame = ctk.CTkFrame(self, fg_color="transparent")
        main_frame.pack(fill="both", expand=True, padx=20, pady=20)

        # Header
        header_frame = ctk.CTkFrame(main_frame, fg_color="transparent")
        header_frame.pack(fill="x", pady=(0, 20))

        title_label = ctk.CTkLabel(
            header_frame,
            text="🔐 Secure Persian Link Encoder",
            font=ctk.CTkFont(size=24, weight="bold"),
        )
        title_label.pack()

        subtitle_label = ctk.CTkLabel(
            header_frame,
            text="Encrypt URLs into Persian text - Fully Offline & Secure",
            font=ctk.CTkFont(size=12),
            text_color="gray",
        )
        subtitle_label.pack()

        # Theme toggle button
        theme_frame = ctk.CTkFrame(main_frame, fg_color="transparent")
        theme_frame.pack(fill="x", pady=(0, 10))

        self.theme_switch = ctk.CTkSwitch(
            theme_frame,
            text="🌙 Dark Mode",
            command=self.toggle_theme,
            onvalue="on",
            offvalue="off",
        )
        self.theme_switch.pack(side="left")
        self.theme_switch.select()  # Start with dark mode

        # Tabview for Encrypt/Decrypt
        self.tabview = ctk.CTkTabview(main_frame, width=650, height=550)
        self.tabview.pack(fill="both", expand=True)

        # Add tabs
        self.tabview.add("🔒 Encrypt")
        self.tabview.add("🔓 Decrypt")

        # Create encrypt tab content
        self.create_encrypt_tab()

        # Create decrypt tab content
        self.create_decrypt_tab()

        # Footer
        footer_label = ctk.CTkLabel(
            main_frame,
            text="Made with ❤️ | AES-256-GCM Encryption | Python + CustomTkinter",
            font=ctk.CTkFont(size=10),
            text_color="gray",
        )
        footer_label.pack(pady=(10, 0))

    def create_encrypt_tab(self):
        """Create encrypt tab UI"""
        tab = self.tabview.tab("🔒 Encrypt")

        # URL Input
        url_label = ctk.CTkLabel(tab, text="🔗 URL to Encrypt:", anchor="w")
        url_label.pack(fill="x", pady=(10, 5))

        self.url_entry = ctk.CTkEntry(
            tab,
            placeholder_text="https://example.com/path",
            height=40,
            font=ctk.CTkFont(size=13),
        )
        self.url_entry.pack(fill="x", pady=(0, 15))

        # Password Input
        password_label = ctk.CTkLabel(tab, text="🔑 Password (Optional):", anchor="w")
        password_label.pack(fill="x", pady=(0, 5))

        password_frame = ctk.CTkFrame(tab, fg_color="transparent")
        password_frame.pack(fill="x", pady=(0, 15))

        self.password_entry = ctk.CTkEntry(
            password_frame,
            placeholder_text="Leave empty for default encryption",
            show="●",
            height=40,
            font=ctk.CTkFont(size=13),
        )
        self.password_entry.pack(side="left", fill="x", expand=True, padx=(0, 10))

        self.show_password_btn = ctk.CTkButton(
            password_frame, text="👁️", width=50, command=self.toggle_encrypt_password
        )
        self.show_password_btn.pack(side="right")

        # Encrypt Button
        encrypt_btn = ctk.CTkButton(
            tab,
            text="🔒 Encrypt URL",
            command=self.encrypt_url,
            height=45,
            font=ctk.CTkFont(size=15, weight="bold"),
            fg_color="#5865F2",
            hover_color="#4752C4",
        )
        encrypt_btn.pack(fill="x", pady=(0, 15))

        # Output Label
        output_label = ctk.CTkLabel(tab, text="📄 Encrypted Persian Text:", anchor="w")
        output_label.pack(fill="x", pady=(0, 5))

        # Output Textbox
        self.encrypted_output = ctk.CTkTextbox(
            tab,
            height=150,
            font=ctk.CTkFont(size=12, family="Courier New"),
            wrap="word",
        )
        self.encrypted_output.pack(fill="both", expand=True, pady=(0, 10))

        # Button Frame
        button_frame = ctk.CTkFrame(tab, fg_color="transparent")
        button_frame.pack(fill="x")

        copy_btn = ctk.CTkButton(
            button_frame,
            text="📋 Copy",
            command=lambda: self.copy_text(self.encrypted_output),
            height=35,
        )
        copy_btn.pack(side="left", fill="x", expand=True, padx=(0, 5))

        reset_btn = ctk.CTkButton(
            button_frame,
            text="🔄 Reset",
            command=self.reset_encrypt,
            height=35,
            fg_color="gray",
            hover_color="darkgray",
        )
        reset_btn.pack(side="right", fill="x", expand=True, padx=(5, 0))

        # Info box
        info_frame = ctk.CTkFrame(
            tab, fg_color="#2b2b2b", border_width=1, border_color="#404040"
        )
        info_frame.pack(fill="x", pady=(10, 0))

        info_label = ctk.CTkLabel(
            info_frame,
            text="ℹ️  Without password, anyone with this tool can decrypt.\n"
            "With password, only those who know it can decrypt.",
            font=ctk.CTkFont(size=11),
            justify="left",
            text_color="#aaaaaa",
        )
        info_label.pack(padx=10, pady=10)

    def create_decrypt_tab(self):
        """Create decrypt tab UI"""
        tab = self.tabview.tab("🔓 Decrypt")

        # Persian Text Input
        persian_label = ctk.CTkLabel(
            tab, text="📄 Persian Text to Decrypt:", anchor="w"
        )
        persian_label.pack(fill="x", pady=(10, 5))

        self.persian_input = ctk.CTkTextbox(
            tab,
            height=150,
            font=ctk.CTkFont(size=12, family="Courier New"),
            wrap="word",
        )
        self.persian_input.pack(fill="both", expand=True, pady=(0, 15))

        # Password Input
        password_label = ctk.CTkLabel(
            tab, text="🔑 Password (if used during encryption):", anchor="w"
        )
        password_label.pack(fill="x", pady=(0, 5))

        password_frame = ctk.CTkFrame(tab, fg_color="transparent")
        password_frame.pack(fill="x", pady=(0, 15))

        self.decrypt_password_entry = ctk.CTkEntry(
            password_frame,
            placeholder_text="Leave empty if no password was used",
            show="●",
            height=40,
            font=ctk.CTkFont(size=13),
        )
        self.decrypt_password_entry.pack(
            side="left", fill="x", expand=True, padx=(0, 10)
        )

        self.show_decrypt_password_btn = ctk.CTkButton(
            password_frame, text="👁️", width=50, command=self.toggle_decrypt_password
        )
        self.show_decrypt_password_btn.pack(side="right")

        # Decrypt Button
        decrypt_btn = ctk.CTkButton(
            tab,
            text="🔓 Decrypt URL",
            command=self.decrypt_url,
            height=45,
            font=ctk.CTkFont(size=15, weight="bold"),
            fg_color="#5865F2",
            hover_color="#4752C4",
        )
        decrypt_btn.pack(fill="x", pady=(0, 15))

        # Output Label
        output_label = ctk.CTkLabel(tab, text="🔗 Decrypted URL:", anchor="w")
        output_label.pack(fill="x", pady=(0, 5))

        # Output Entry
        self.decrypted_output = ctk.CTkEntry(
            tab, height=40, font=ctk.CTkFont(size=13), state="readonly"
        )
        self.decrypted_output.pack(fill="x", pady=(0, 10))

        # Button Frame
        button_frame = ctk.CTkFrame(tab, fg_color="transparent")
        button_frame.pack(fill="x")

        copy_btn = ctk.CTkButton(
            button_frame,
            text="📋 Copy",
            command=lambda: self.copy_text(self.decrypted_output),
            height=35,
        )
        copy_btn.pack(side="left", fill="x", expand=True, padx=(0, 5))

        open_btn = ctk.CTkButton(
            button_frame, text="🌐 Open URL", command=self.open_url, height=35
        )
        open_btn.pack(side="left", fill="x", expand=True, padx=(5, 5))

        reset_btn = ctk.CTkButton(
            button_frame,
            text="🔄 Reset",
            command=self.reset_decrypt,
            height=35,
            fg_color="gray",
            hover_color="darkgray",
        )
        reset_btn.pack(side="right", fill="x", expand=True, padx=(5, 0))

    def toggle_theme(self):
        """Toggle between dark and light mode"""
        if self.theme_switch.get() == "on":
            ctk.set_appearance_mode("dark")
            self.theme_switch.configure(text="🌙 Dark Mode")
        else:
            ctk.set_appearance_mode("light")
            self.theme_switch.configure(text="☀️ Light Mode")

    def toggle_encrypt_password(self):
        """Toggle password visibility for encrypt tab"""
        if self.password_entry.cget("show") == "●":
            self.password_entry.configure(show="")
            self.show_password_btn.configure(text="🙈")
        else:
            self.password_entry.configure(show="●")
            self.show_password_btn.configure(text="👁️")

    def toggle_decrypt_password(self):
        """Toggle password visibility for decrypt tab"""
        if self.decrypt_password_entry.cget("show") == "●":
            self.decrypt_password_entry.configure(show="")
            self.show_decrypt_password_btn.configure(text="🙈")
        else:
            self.decrypt_password_entry.configure(show="●")
            self.show_decrypt_password_btn.configure(text="👁️")

    def encrypt_url(self):
        """Encrypt URL to Persian text"""
        url = self.url_entry.get().strip()
        password = self.password_entry.get()

        if not url:
            messagebox.showwarning("Warning", "Please enter a URL!")
            return

        try:
            # Validate URL
            if not url.startswith(("http://", "https://")):
                raise ValueError("URL must start with http:// or https://")

            # Encrypt
            persian_text = self.crypto.encrypt(url, password if password else None)

            # Display result
            self.encrypted_output.delete("1.0", "end")
            self.encrypted_output.insert("1.0", persian_text)

            messagebox.showinfo("Success", "✅ URL encrypted successfully!")

        except Exception as e:
            messagebox.showerror("Error", f"❌ Encryption failed:\n{str(e)}")

    def decrypt_url(self):
        """Decrypt Persian text to URL"""
        persian_text = self.persian_input.get("1.0", "end").strip()
        password = self.decrypt_password_entry.get()

        if not persian_text:
            messagebox.showwarning("Warning", "Please enter Persian text!")
            return

        try:
            # Decrypt
            url = self.crypto.decrypt(persian_text, password if password else None)

            # Display result
            self.decrypted_output.configure(state="normal")
            self.decrypted_output.delete(0, "end")
            self.decrypted_output.insert(0, url)
            self.decrypted_output.configure(state="readonly")

            messagebox.showinfo("Success", "✅ URL decrypted successfully!")

        except Exception as e:
            messagebox.showerror(
                "Error",
                f"❌ Decryption failed!\n\nPossible reasons:\n- Wrong password\n- Corrupted data\n- Invalid Persian text",
            )

    def copy_text(self, widget):
        """Copy text from widget to clipboard"""
        if isinstance(widget, ctk.CTkTextbox):
            text = widget.get("1.0", "end").strip()
        else:
            text = widget.get().strip()

        if not text:
            messagebox.showwarning("Warning", "Nothing to copy!")
            return

        try:
            pyperclip.copy(text)
            messagebox.showinfo("Success", "✅ Copied to clipboard!")
        except Exception as e:
            messagebox.showerror("Error", f"Failed to copy: {str(e)}")

    def open_url(self):
        """Open decrypted URL in browser"""
        url = self.decrypted_output.get().strip()

        if not url:
            messagebox.showwarning("Warning", "No URL to open!")
            return

        try:
            webbrowser.open(url)
        except Exception as e:
            messagebox.showerror("Error", f"Failed to open URL: {str(e)}")

    def reset_encrypt(self):
        """Reset encrypt tab"""
        self.url_entry.delete(0, "end")
        self.password_entry.delete(0, "end")
        self.encrypted_output.delete("1.0", "end")

    def reset_decrypt(self):
        """Reset decrypt tab"""
        self.persian_input.delete("1.0", "end")
        self.decrypt_password_entry.delete(0, "end")
        self.decrypted_output.configure(state="normal")
        self.decrypted_output.delete(0, "end")
        self.decrypted_output.configure(state="readonly")


def main():
    """Main entry point"""
    app = SecurePersianLinkApp()
    app.mainloop()


if __name__ == "__main__":
    main()
