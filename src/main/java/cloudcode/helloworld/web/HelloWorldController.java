
package cloudcode.helloworld.web;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Defines a controller to handle HTTP requests.
 */
@Controller
public final class HelloWorldController {

    /**
     * Create an endpoint for the landing page
     * @return the index view template with a simple message
     */
    @GetMapping("/")
    public String helloWorld(Model model) {
        String message = "Hello! This is a demo for my blog fans! ";
        model.addAttribute("message", message);
        return "index";
    }
}
