package com.company.vehiclewash.assignment.controller;

import com.company.vehiclewash.assignment.dto.AssignmentResponseDTO;
import com.company.vehiclewash.assignment.service.AssignmentService;
import com.company.vehiclewash.common.response.ApiResponse;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.UUID;

@RestController
@RequestMapping("/api/v1/assignments")
public class AssignmentController {

    private final AssignmentService assignmentService;

    public AssignmentController(AssignmentService assignmentService) {
        this.assignmentService = assignmentService;
    }

    @GetMapping("/me/requests")
    public ResponseEntity<ApiResponse<List<AssignmentResponseDTO>>> getIncomingRequests() {
        List<AssignmentResponseDTO> response = assignmentService.getIncomingRequests();
        return ResponseEntity.ok(ApiResponse.success(response));
    }

    @PostMapping("/{requestId}/accept")
    public ResponseEntity<ApiResponse<Void>> acceptAssignment(@PathVariable UUID requestId) {
        assignmentService.acceptAssignment(requestId);
        return ResponseEntity.ok(ApiResponse.success(null));
    }

    @PostMapping("/{requestId}/reject")
    public ResponseEntity<ApiResponse<Void>> rejectAssignment(@PathVariable UUID requestId) {
        assignmentService.rejectAssignment(requestId);
        return ResponseEntity.ok(ApiResponse.success(null));
    }
}
